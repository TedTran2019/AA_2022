class CommentsController < ApplicationController
  before_action :require_logged_in

  def create
    @comment = Comment.new(comment_params)
    @comment.author_id = current_user.id
    unless @comment.save
      flash[:errors] = @comment.errors.full_messages
    end
    redirect_to request.referrer
  end

  private

    def comment_params
      params.require(:comment).permit(:description, :commentable_type, :commentable_id)
    end
end
