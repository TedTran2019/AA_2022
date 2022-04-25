class GoalsController < ApplicationController
  before_action :require_logged_in
  before_action :set_goal, only: %i[edit update destroy]

  def index
    @goals = Goal.where("user_id = ? OR private = 'false'", current_user.id)
  end

  def show
    @goal = Goal.find(params[:id])
    @goal = nil if (@goal.private == true) && (@goal.user_id != current_user.id)

    if @goal
      render :show
    else
      flash[:errors] = 'Goal was not found'
      redirect_to goals_url, status: 404
    end
  end

  def new
    @goal = Goal.new
  end

  def edit
    if @goal
      render :edit
    else
      flash[:errors] = 'Goal was not found'
      redirect_to goals_url, status: 404
    end
  end

  def create
    @goal = Goal.new(goal_params)
    @goal.user_id = current_user.id
    if @goal.save
      redirect_to goal_url(@goal)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :new, status: 422
    end
  end

  def update
    unless @goal
      flash[:errors] = 'Goal was not found'
      redirect_to goals_url, status: 404
      return
    end

    if @goal.update(goal_params)
      redirect_to goal_url(@goal)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :edit, status: 422
    end
  end

  def destroy
    if @goal
      @goal.destroy
      redirect_to goals_url
    else
      flash[:errors] = 'Goal was not found'
      redirect_to goals_url, status: 404
    end
  end

  private
    def set_goal
      @goal = current_user.goals.find_by(id: params[:id])
    end

    # Only allow a list of trusted parameters through.
    def goal_params
      params.require(:goal).permit(:private, :completed, :title, :details)
    end
end
