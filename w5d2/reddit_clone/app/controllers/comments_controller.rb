class CommentsController < ApplicationController
  before_action :require_logged_in

  def new
    @comment = Comment.new
    render :new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.author_id = current_user.id
    if @comment.save
      redirect_to post_url(@comment.post_id)
    else
      flash.now[:errors] = @comment.errors.full_messages
      render :new, status: 422
    end
  end

  def show
    @comment = Comment.find_by(id: params[:id])
    if @comment
      render :show
    else
      render json: 'Comment not found', status: 404
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id, :parent_comment_id)
  end
end