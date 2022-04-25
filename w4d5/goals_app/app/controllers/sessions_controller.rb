class SessionsController < ApplicationController
  before_action :require_logged_out, only: %i[new create]
  before_action :require_logged_in, only: %i[destroy]

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(params[:user][:username], params[:user][:password])
    if @user
      login!(@user)
      redirect_to user_url(@user)
    else
      @user = User.new(username: params[:user][:username])
      flash.now[:errors] = 'Invalid username or password'
      render :new, status: 422
    end
  end

  def destroy
    logout! if logged_in?
    redirect_to new_session_url
  end

  private 

  def user_params
    params.require(:user).permit(:username, :password)
  end
end