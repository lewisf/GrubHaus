class ApplicationController < ActionController::Base
  protect_from_forgery :except => [:create, :search, :update, :destroy]

end
