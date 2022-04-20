class CommentsController < ApplicationController
  def create
    new_comment = Comment.new(comment_params)
    if new_comment.save
      render json: new_comment
    else
      render json: new_comment.errors.full_messages, status: :unprocessable_entity
    end
  end
  
  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    render json: comment
  end

  def index
    if params[:user_id]
      render json: User.find(params[:user_id]).comments
    elsif params[:artwork_id]
      render json: Artwork.find(params[:artwork_id]).comments
    else
      render json: Comment.all
    end
  end

  def comment_params
    params.require(:comment).permit(:body, :author_id, :artwork_id)
  end
end