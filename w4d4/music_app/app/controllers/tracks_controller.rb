class TracksController < ApplicationController
  before_action :must_be_logged_in!

  def new
    @track = Track.new
    render :new
  end
  
  def create
    @track = Track.new(track_params)
    if @track.save
      redirect_to track_url(@track)
    else
      render :new
    end
  end
  
  def edit
    @track = Track.find_by(id: params[:id])
    if @track
      render :edit
    else
      render json: 'Not found', status: 404
    end
  end

  def update
    @track = Track.find_by(id: params[:id])
    if @track.update(track_params)
      redirect_to track_url(@track)
    else
      render :edit
    end
  end

  def destroy
    @track = Track.find_by(id: params[:id])
    @track&.destroy
    redirect_to album_url(@track.album_id)
  end

  def show
    @note = Note.new
    @track = Track.find_by(id: params[:id])
    if @track
      render :show
    else
      render json 'Not found', status: 404
    end
  end

  def track_params
    params.require(:track).permit(:title, :ord, :lyrics, :bonus, :album_id)
  end
end