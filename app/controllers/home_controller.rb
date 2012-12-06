class HomeController < ApplicationController

  def index
    @user = current_user
	respond_to do |format|
      format.html # index.html.haml
    end
  end

end
