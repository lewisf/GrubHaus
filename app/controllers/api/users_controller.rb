class Api::UsersController < ApplicationController

  def show
    @user = User.find(params[:id])

    respond_to do |format|
      if @user
        format.json { render :json => @user }
      else
        raise MongoidErrors::DocumentNotFound
      end
    end
  end

end 
