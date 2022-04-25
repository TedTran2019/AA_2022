class NotesController < ApplicationController
  def create
    @track = Track.find_by(id: params[:note][:track_id])
    @note = Note.new(note_params)
    @note.user_id = current_user.id
    @note.track_id = @track.id
    if @note.save
      redirect_to track_url(@track.id)
    else
      render 'tracks/show'
    end
  end

  def destroy
    @note = Note.find_by(id: params[:id])
    unless current_user.id == @note.user_id
      render json: 'FORBIDDEN', status: 403
      return 'NOPE ;)'
    end

    @note.destroy
    redirect_to track_url(@note.track_id)
  end

  def note_params
    params.require(:note).permit(:description, :track_id)
  end
end