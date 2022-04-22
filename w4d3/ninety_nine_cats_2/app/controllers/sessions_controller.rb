class SessionsController < ApplicationController
  before_action :return_if_logged_in, only: [:new, :create]
  
  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(params[:user][:user_name], params[:user][:password])
    if @user
      @user.reset_session_token!
      session[:session_token] = @user.session_token
      redirect_to cats_url
    else
      @user = User.new(user_params)
      render :new
    end
  end

  def destroy
    user = current_user
    if user
      user.reset_session_token!
      @current_user = nil
      session[:session_token] = nil
      redirect_to cats_url
    end
  end

  def user_params
    params.require(:user).permit(:user_name, :password)
  end
end