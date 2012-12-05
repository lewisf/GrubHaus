class Api::UsersController < ApplicationController

  def show
    @user = if params[:id] then User.find params[:id] else current_user end

    if @user
      @user.current_user = current_user
      render :json => @user.to_json(:methods => [:editable_by_user])
    end
  end

  def update
    @user = if params[:id] then User.find params[:id] else current_user end
    @profile = @user.profile
    Rails.logger.info params[:user][:profile]

    if @user.update_attributes params[:user] and @profile.update_attributes params[:profile]
      render :json => @user
    end
  end

end 
