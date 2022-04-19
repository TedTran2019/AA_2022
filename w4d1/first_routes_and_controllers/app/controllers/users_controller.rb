class UsersController < ApplicationController
  def index
    users = User.all
    render json: users
  end

  def create
    user = User.new(permits(params))
    if user.save
      render json: user
    else
      render json: user.errors.full_messages, status: :unprocessable_entity
    end
  end

  def show
    user = User.find(params[:id])
    if user
      render json: user
    else
      render plain: 'User not found!'
    end
  end

  def update
    user = User.find(params[:id])
    if user
      User.update(params[:id], permits(params))
      render json: user
    else
      render plain: 'User not found!'
    end
  end

  def destroy
    user = User.find(params[:id])
    if user
      user.destroy
      render plain: 'Sucess!'
    else
      render plain: 'User not found!'
    end
  end

  private

  def permits(params)
    params.require(:user).permit(:name, :email)
  end
end