class Api::StepsController < ApplicationController
 def show
    render json: Step.find(params[:id])
  end

  def index
    render json: Step.all
  end

  def create
    @step = Step.new(step_params)
    if @step.save
      render json: @step
    else
      render json: @step.errors.full_messages, status: 422
    end
  end

  def update
    @step = Step.find(params[:id])
    if @step.update(step_params)
      render json: @step
    else
      render json: @step.errors.full_messages, status: 422
    end
  end

  def destroy
    @step = Step.find(params[:id])
    @step.destroy
    render json: @step
  end

  private

  def step_params
    params.require(:step).permit(:title, :body, :done, :todo_id)
  end
end
