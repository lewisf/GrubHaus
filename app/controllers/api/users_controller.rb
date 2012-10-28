class Api::UsersController < ApplicationController

  def show
    @user = User.find(params[:id])

    respond_to do |format|
      if @user
        format.json { render :json => @user }
      else
        raise ActiveRecord::RecordNotFound
      end
    end
  end

end 
