class UsersController < ApplicationController
  before_action :return_if_logged_in, only: [:new, :create]

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.reset_session_token!
      session[:session_token] = @user.session_token
      redirect_to cats_url
    else
      render :new
    end
  end

  def user_params
    params.require(:user).permit(:user_name, :password)
  end

  has_many :cats
end