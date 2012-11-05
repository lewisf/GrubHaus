class Api::RecipesController < ApplicationController

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
    @recipe = Recipe.new(params)
    respond_to do |format|
      if @recipe.save
        format.json { render :json => [] }
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
