class HomeController < ApplicationController
  # before_filter :authenticate_user!

	def index
		respond_to do |format|
      format.html # index.html.haml
		end
	end

end