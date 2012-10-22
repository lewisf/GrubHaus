class Api::RecipesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @amount = params[:amount] || 25
    @offset = params[:page] * @amount

    @recipes = Recipe.where(published: true).limit(25).offset(@offset)

    respond_to do |format|
      format.json { render :json => @recipes }
    end
  end

  def show
    @recipe = Recipe.find(params[:id])

    respond_to do |format|
      format.json { render :json => @recipe }
    end
  end

end