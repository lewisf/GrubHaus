class Api::RecipesController < ApplicationController
  include ActiveModel::MassAssignmentSecurity

  def index
    # @amount = params[:amount].to_i || 25
    # @page = params[:page].to_i - 1
    # @offset = @page * @amount

    case params[:listing]
    when "recent"
      @recipes = Recipe.all
    when "favorited"
      @recipes = Recipe.all
    else
      @recipes = Recipe.where(published: true).entries
    end

    #@recipes = Recipe.where(published: true).limit(@amount).offset(@offset)

    render :json => @recipes
  end

  def search
    @recipes = Recipe.search params[:q]
    @tag = Tag.where(:name => params[:q]).first
    unless @tag.nil?
      @combined_recipes = @recipes.entries.concat @tag.recipes.entries 
    else
      @combined_recipes = @recipes
    end
    
    render :json => @combined_recipes
  end

  def create
    recipe = sanitize_for_mass_assignment(params[:recipe], :default)
    name = params[:name]
    photo = params[:photo]
    description = params[:description]
    prep_time = params[:prep_time]
    cook_time = params[:cook_time]
    ready_in = params[:ready_in]
    serving_size = params[:serving_size]
    recipe_ingredients = params[:recipe_ingredients]
    steps = params[:steps]
    tags = params[:all_tags]
    unless name == "Double click here to edit the recipe name."
      @recipe = Recipe.new do |r|
        r.name = name
        r.photo = photo
        r.description = description
        r.prep_time = prep_time
        r.cook_time = cook_time
        r.ready_in = ready_in
        r.serving_size = serving_size
        recipe_ingredients.each do |ing|
          r.recipe_ingredients.new do |re_ing|
            re_ing.name = ing['name']
            re_ing.amount = ing['amount']
            re_ing.unit = ing['unit']
          end
        end
        steps.each do |step|
          r.steps.new do |x|
            x.description = step['description']
            x.start_time = step['start_time']
            x.end_time = step['end_time']
          end
        end
      end
      @user = current_user
      @user.recipes << @recipe
      @recipe.update_tags tags
    else
      @recipe = "Invalid recipe."
    end
    if @recipe == "Invalid recipe." || @recipe.save 
      render :json => @recipe
    end
  end

  def show
    @recipe = Recipe.find params[:id]
    @recipe.current_user = current_user || User.new

    if @recipe
      render :json => @recipe.to_json(:methods => [:is_favorited_by_user,
                                                   :is_authored_by_user,
                                                   :author_name,
                                                   :current_user_is_admin,
                                                   :all_tags])
    end
  end

  def update
    @recipe = Recipe.find(params[:id])
    tags = params[:all_tags]
    @recipe.update_tags tags
    # raise MongoidErrors::DocumentNotFound unless @recipe

    if current_user == @recipe.author || current_user.admin
      if @recipe.update_attributes! params[:recipe]
        render :json => @recipe
      end
    end
  end

  def destroy
    @recipe = Recipe.find params[:id] 
    if current_user == @recipe.author || current_user.admin
      @recipe.destroy
      render :json => []
    end
  end

  def favorites
    user = params[:id].present? ? User.find(params[:id]) : current_user
    @favorites = user.favorites.all.entries
    @favorites.each { |x| x.current_user = current_user }

    render :json => @favorites.to_json(:methods => [:is_authored_by_user, :current_user_is_admin])
  end

  def unpublished
    @recipes = current_user.recipes.where(:published => false).entries
    @recipes.each { |x| x.current_user = current_user }

    render :json => @recipes.to_json(:methods => [:is_authored_by_user, :current_user_is_admin])
  end

  def published
    user = params[:id].present? ? User.find(params[:id]) : current_user
    @recipes = user.recipes.where(:published => true).entries
    @recipes.each { |x| x.current_user = current_user }

    render :json => @recipes.to_json(:methods => [:is_authored_by_user, :current_user_is_admin])
  end

  def favorite
    @user = current_user
    @recipe = Recipe.find params[:id]
    @user.favorites << @recipe

    if @user.save
      render :json => @recipe
    end
  end

  def unfavorite
    @user = current_user
    @recipe = Recipe.find params[:id]

    @user.favorites.delete @recipe

    if @user.save
      render :json => @recipe
    end
  end

  def fork
    @user = current_user
    @recipe = Recipe.find params[:id]
    @new_recipe = @recipe.fork_to @user
    render :json => @new_recipe
  end

end
