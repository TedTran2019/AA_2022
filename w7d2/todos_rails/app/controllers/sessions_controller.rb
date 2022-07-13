class SessionsController < ApplicationController
  before_action :require_logged_out, only: %i[new create]
  before_action :require_logged_in, only: %i[destroy]
  
  def new
    @user = User.new
    render :new
  end
  
  def create
    @user = User.find_by_credentials(user_params[:username], user_params[:password])
    if @user
      login!(@user)
      redirect_to root_url
    else
      flash.now[:errors] = ["Invalid username or password"]
      render :new, status: 422
    end
  end

  def destroy
    if logout!
      redirect_to new_session_url
    else
      redirect_to request.referrer
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
