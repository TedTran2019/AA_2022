class CatRentalRequestsController < ApplicationController
  def new
    @cat_rental_request = CatRentalRequest.new
    @cats = Cat.all
    render :new
  end

  def create
    @cat_rental_request = CatRentalRequest.new(cat_rental_request_params)
    @cats = Cat.all
    if @cat_rental_request.save
      redirect_to cat_url(@cat_rental_request.cat_id)
    else
      render :new
    end
  end

  def approve
    request = CatRentalRequest.find_by(id: params[:id])
    request.approve!
    redirect_to cat_url(request.cat_id)
  end
  
  def deny
    request = CatRentalRequest.find_by(id: params[:id])
    request.deny!
    redirect_to cat_url(request.cat_id)
  end

  def cat_rental_request_params
    params.require(:cat_rental_request).permit(:cat_id, :start_date, :end_date)
  end
end
