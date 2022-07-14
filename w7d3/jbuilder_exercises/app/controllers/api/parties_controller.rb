class Api::PartiesController < ApplicationController
  def index
    @parties = Party.all.includes(:guests)
    render :index
  end

  def show
    @party = Party.where(id: params[:id]).includes(:guests => [:gifts])[0]
    render :show
  end
end
