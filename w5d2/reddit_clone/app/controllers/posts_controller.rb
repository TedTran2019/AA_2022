class PostsController < ApplicationController
  def show
    @post = Post.find_by(id: params[:id])
    if @post
      @comments = @post.comments_by_parent_id
      render :show
    else
      flash.now[:errors] = 'Post not found'
      render json: 'Post not found', status: 404
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id
    if @post.save
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new, status: 422
    end
  end

  def edit
    @post = Post.find_by(id: params[:id])
    if @post
      render :edit
    else
      flash.now[:errors] = 'Post not found'
      render json: 'Post not found', status: 404
    end
  end

  def update
    @post = Post.find_by(id: params[:id])
    if @post&.update(post_params)
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit, status: 422
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    if @post
      @post.destroy
      redirect_to subs_url
    else
      flash.now[:errors] = 'Post not found'
      render json: 'Post not found', status: 404
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :content, sub_ids: [])
  end
end
