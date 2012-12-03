class Api::UsersController < ApplicationController

  def show
    @user = if params[:id] then User.find params[:id] else current_user end

    if @user
      @user.current_user = current_user
      render :json => @user.to_json(:methods => [:editable_by_user])
    end
  end

end 
