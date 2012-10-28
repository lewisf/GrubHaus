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

  def edit
    @comment = Comment.find(params[:id])
    
    respond_to do |format|
      format.json { render :json => @comment }
    end
  end

  def create
    @comment = Comment.new(params[:id])
    respond_to do |format|
      if @comment.save
        format.json { render :json => @comment }
      else
        format.json { render :json => [] }
      end
    end
  end

  def update
    @comment = Comment.new(params[:id])
    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.json { render :json => @comment }
      else
        format.json { render :json => [] }
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      if @comment.update_attribute(params[:comments])
      end
  end

end
