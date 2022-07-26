class Api::BenchesController < ApplicationController
  def index
    @benches = Bench.in_bounds(params[:bounds])
    @benches = filter_by_seats(@benches)
    render :index
  end

  def create
    @bench = Bench.new(bench_params)
    if @bench.save
      render :show
    else
      render json: @bench.errors.full_messages, status: 422
    end
  end

  def show
    @bench = Bench.find(params[:id])
    render :show
  end

  private

  def filter_by_seats(benches)
    benches = benches.where("seating >= ?", params[:min_seating]) if params[:min_seating]
    benches = benches.where("seating <= ?", params[:max_seating]) if params[:max_seating]
    benches
  end

  def bench_params
    params.require(:bench).permit(:description, :lat, :lng, :seating, 
      :rating, :comment, :max_seating, :min_seating)
  end
end
