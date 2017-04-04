class HabitsController < ApplicationController
  before_filter :authenticate_user
  before_action :set_habit, only: [:show, :edit, :update, :destroy]

  def index
    @doing_habits = Habit.doing_habits(current_user.id)
    @completed_habits = Habit.completed_habits(current_user.id)
  end

  def new
    @habit = Habit.new
    @days = Day.all
  end

  def create
    @habit = Habit.new(new_habit_params.merge(user: current_user))
    if @habit.create_habit_achivements(params[:habit][:day_ids])
      flash[:success] = '保存しました'
      redirect_to root_path
    else
      flash[:danger] = '失敗しました'
      redirect_to root_path
    end
  end

  def edit
    @days = Day.all
  end

  def update
    if @habit.update(update_habit_params)
      flash[:success] = '保存しました'
      redirect_to root_path
    else
      flash[:danger] = '失敗しました'
      redirect_to root_path
    end
  end

  def destroy
    if @habit.destroy
      flash[:success] = '削除しました'
      redirect_to root_path
    else
      flash[:danger] = '失敗しました'
      redirect_to root_path
    end
  end

  private
    def set_habit
      @habit = Habit.find(params[:id])
    end

    def new_habit_params
      params.require(:habit).permit(:name, :purpose, :goal, :start_date, :end_date)
    end

    def update_habit_params
      params.require(:habit).permit(:name, :purpose, :goal)
    end
end
