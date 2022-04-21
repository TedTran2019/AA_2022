class CatsController < ApplicationController
  def index
    @cats = Cat.all
  end

  def show
    @cat = Cat.find_by(id: params[:id])
    if @cat
      render :show
    else
      render json: 'Kitty not found in database!'
    end
  end

  def create
    @new_cat = Cat.new(cat_params)
    if @new_cat.save
      redirect_to cat_url(@new_cat)
    else
      render :new
    end
  end

  def update
    @cat = Cat.find_by(id: params[:id])
    if @cat
      if @cat.update(cat_params)
        redirect_to cat_url(@cat)
      else
        render :edit
      end
    else
      render json: 'Kitty not found in database!'
    end
  end

  def new
    @new_cat = Cat.new
    render :new
  end

  def edit
    @cat = Cat.find_by(id: params[:id])
    if @cat
      render :edit
    else
      render json: 'Kitty not found in database!'
    end
  end

  def cat_params
    params.require(:cat).permit(:birth_date, :color, :name, :sex, :description)
  end
end