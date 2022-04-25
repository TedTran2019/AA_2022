class AlbumsController < ApplicationController
  before_action :must_be_logged_in!
  
  def new
    @album = Album.new
    render :new
  end

  def create
    @album = Album.new(album_params)
    # @album.band_id = params[:band_id]
    if @album.save
      redirect_to album_url(@album)
    else
      render :new
    end
  end

  def edit
    @album = Album.find_by(id: params[:id])
    if @album
      render :edit
    else
      render json: 'Album not found', status: 404
    end
  end

  def update
    @album = Album.find_by(id: params[:id])
    if @album.update(album_params)
      redirect_to album_url(@album)
    else
      render :edit
    end
  end

  def show
    @album = Album.find_by(id: params[:id])
    if @album
      render :show
    else
      render json: 'Album not found', status: 404
    end
  end

  def destroy
    @album = Album.find_by(id: params[:id])
    @album&.destroy
    redirect_to band_url(@album.band_id)
  end

  private
  
  def album_params
    params.require(:album).permit(:title, :year, :live, :band_id)
  end
end