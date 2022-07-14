class Api::GuestsController < ApplicationController
  def index
    @guests = Guest.all
    render :index
  end

  def show
    @guest = Guest.where(id: params[:id]).includes(:gifts)[0]
    render :show
  end
end
