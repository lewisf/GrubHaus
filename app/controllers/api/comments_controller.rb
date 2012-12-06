class Api::CommentsController < ApplicationController

  def index
    @amount = params[:amount].to_i || 25
    @page = params[:page].to_i - 1
    @offset = @page * @amount

    @comments = Comment.where(:parent => params[:parent]).
                        order_by('created_at asc').
                        limit(@amount).offset(@offset)

    respond_to do |format|
      format.json { 
        render :json => @comments.to_json(:include => { :author => { :only => :username }}) 
      }
    end
  end

  def show
    @comment = Comment.find(params[:id])

    respond_to do |format|
      if @comment
        format.json { render :json => @comment }
      else
        # raise MongoidErrors::DocumentNotFound
      end
    end
  end

  def create
    @comment = Comment.new params[:comment]
    @comment.author = current_user
    recipe = Recipe.where("steps._id" => Moped::BSON::ObjectId(params[:parent])).first
    step = recipe.steps.find(params[:parent])
    step.comments << @comment
    recipe.save

    respond_to do |format|
      if @comment.save
        format.json { render :json => @comment }
      else
        format.json { render :json => [] }
      end
    end
  end

  def update
    @comment = Comment.find(params[:id])
    # raise MongoidErrors::DocumentNotFound unless @comment

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
    # raise MongoidErrors::DocumentNotFound unless @comment
    @comment.destroy

    respond_to do |format|
      if @comment.update_attribute(params[:comments])
        format.json { render :json => [] }
      end
    end
  end

end
