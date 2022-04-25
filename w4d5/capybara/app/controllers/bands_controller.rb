class BandsController < ApplicationController
  before_action :must_be_logged_in!

  def new
    @band = Band.new
    render :new
  end

  def create
    @band = Band.new(band_params)
    if @band.save
      redirect_to band_url(@band)
    else
      render :new
    end
  end

  def edit
    @band = Band.find_by(id: params[:id])
    if @band
      render :edit
    else
      render json: 'Band not found', status: 404
    end
  end

  def update
    @band = Band.find_by(id: params[:id])
    if @band.update(band_params)
      redirect_to band_url(@band)
    else
      render :edit
    end
  end

  def destroy
    @band = Band.find_by(id: params[:id])
    @band.destroy if @band
    redirect_to bands_url
  end

  def show
    @band = Band.find_by(id: params[:id])
    if @band
      render :show
    else
      render json: 'Band not found', status: 404
    end
  end
  
  def index
    @bands = Band.all
    render :index
  end

  def band_params
    params.require(:band).permit(:name)
  end
end