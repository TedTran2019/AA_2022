class SubsController < ApplicationController
  before_action :require_logged_in
  
  def index
    @subs = Sub.all
  end
  
  def show
    @sub = Sub.find_by(id: params[:id])
    if @sub
      render :show
    else
      flash.now[:errors] = 'Sub not found'
      render json: 'Sub not found', status: 404
    end
  end

  def new
    @sub = Sub.new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.moderator_id = current_user.id
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new, status: 422
    end
  end

  def edit
    @sub = current_user.subs.find_by(id: params[:id])
    if @sub
      render :edit
    else
      flash.now[:errors] = 'Sub not found'
      render json: 'Sub not found', status: 404
    end
  end

  def update
    @sub = current_user.subs.find_by(id: params[:id])
    if @sub&.update(sub_params)
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit, status: 422
    end
  end

  def destroy
    @sub = current_user.subs.find_by(id: params[:id])
    if @sub
      @sub.destroy
      redirect_to subs_url
    else
      flash.now[:errors] = 'Sub not found'
      render json: 'Sub not found', status: 404
    end
  end

  private

  def sub_params
    params.require(:sub).permit(:title, :description)
  end
end
