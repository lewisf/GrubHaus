class Api::RecipesController < ApplicationController

  def index
    @amount = params[:amount].to_i || 25
    @page = params[:page].to_i - 1
    @offset = @page * @amount

    @recipes = Recipe.where(published: true).limit(@amount).offset(@offset)

    respond_to do |format|
      format.json { render :json => @recipes }
    end
  end

  def edit
    @recipe = Recipe.where(author: current_user).find(params[:id])
    respond_to do |format|
      format.json { render :json => @recipe }
    end
  end

  def update
    @recipe = Recipe.where(author: current_user).find(params[:id])
    @recipe.update_attributes!(params[:recipe])
    respond_to do |format|
      format.json { render :json => @recipe }
    end
  end

  def show
    @recipe = Recipe.find(params[:id])

    respond_to do |format|
      format.json { render :json => @recipe }
    end
  end

end