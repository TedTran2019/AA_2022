class SessionsController < ApplicationController
  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(params[:user][:email], params[:user][:password])
    if @user
      login!(@user)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = 'Incorrect email or password'
      @user ||= User.new(user_params)
      render :new
    end
  end

  def destroy
    if current_user
      logout!
      redirect_to new_session_url
    else
      flash.now[:errors] = 'Not found!'
      render json: 'No such user found'
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end