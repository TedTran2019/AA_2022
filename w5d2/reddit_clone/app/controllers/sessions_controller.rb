class SessionsController < ApplicationController
  def new
    @user = User.new
    render :new
  end
  
  def create
    @user = User.find_by(username: user_params[:username])
    if @user&.is_password?(user_params[:password])
      login!(@user)
    else
      flash.now[:errors] = 'Invalid username or password'
      render :new
    end
  end

  def destroy
    logout!
    redirect_to new_session_url
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end