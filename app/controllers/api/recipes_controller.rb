class Api::RecipesController < ApplicationController
  include ActiveModel::MassAssignmentSecurity

  def index
    @amount = params[:amount].to_i || 25
    @page = params[:page].to_i - 1
    @offset = @page * @amount

    #@recipes = Recipe.where(published: true).limit(@amount).offset(@offset)
    @recipes = Recipe.all

    respond_to do |format|
      format.json { render :json => @recipes }
    end
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
    @recipe.save!
    respond_to do |format|
      if @recipe.save
        format.json { render :json => @recipe }
      else
        # raise MongoidErrors::UnsavedDocument
      end
    end
  end

  def show
    @recipe = Recipe.find(params[:id])

    respond_to do |format|
      if @recipe
        format.json { render :json => @recipe }
      else
        # raise MongoidErrors::DocumentNotFound
      end
    end
  end

  def update
    @recipe = Recipe.where(author: current_user).find(params[:id])
    # raise MongoidErrors::DocumentNotFound unless @recipe

    respond_to do |format|
      if @recipe.update_attributes!(params[:recipe])
        format.json { render :json => @recipe }
      else
         # raise MongoidErrors::UnsavedDocument
      end
    end
  end

  def destroy
    @recipe = Recipe.where(author: current_user).find(params[:id])
    @recipe.destroy
    respond_to do |format|
      format.json { render :json => [] }
    end
  end

end
