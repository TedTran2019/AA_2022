class UsersController < ApplicationController
  before_action :require_logged_out, only: %i[new create]
  
  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login!(@user)
      redirect_to subs_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new, status: 422
    end
  end

  def show
    @user = User.find_by(id: params[:id])
    if @user
      render :show
    else
      render json: 'User not found', status: 404
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end