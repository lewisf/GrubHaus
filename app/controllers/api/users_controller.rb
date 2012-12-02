class Api::UsersController < ApplicationController

  def show
    @user = if params[:id] then User.find params[:id] else current_user end
    Rails.logger.info @user.username

    render :json => @user if @user
  end

end 
