class Api::CommentsController < ApplicationController

  def index
    @amount = params[:amount].to_i || 25
    @page = params[:page].to_i - 1
    @offset = @page * @amount

    @comments = Comment.limit(@amount).offset(@offset)

    respond_to do |format|
      format.json { render :json => @comments }
    end
  end

  def show
    @comment = Comment.find(params[:id])

    respond_to do |format|
      format.json { render :json => @comment }
    end
  end

end
