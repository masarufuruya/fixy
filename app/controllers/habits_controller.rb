class HabitsController < ApplicationController
  before_filter :authenticate_user
  before_action :set_habit, only: [:show, :edit, :update, :destroy]

  def index
    @doing_habits = Habit.doing_habits(current_user.id)
    @completed_habits = Habit.completed_habits(current_user.id)
  end

  def new
    now = Time.current
    @habit = Habit.new(start_date: now.strftime("%Y-%m-%d"), end_date: now.since(6.days).strftime("%Y-%m-%d"))
    @days = Day.all
  end

  def create
    @habit = Habit.new(new_habit_params.merge(user: current_user))
    error = @habit.create_habit_achivements(params[:habit][:day_ids])[:error]
    if error.present?
      flash[:error_messages] = error
    else
      flash[:success] = "成功しました"
    end
    redirect_to root_path
  end

  def edit
    @days = Day.all
  end

  def update
    if @habit.update(update_habit_params)
      flash[:success] = "保存しました"
    else
      flash[:danger] = "失敗しました"
    end
    redirect_to root_path
  end

  def destroy
    if @habit.destroy
      flash[:success] = "削除しました"
    else
      flash[:danger] = "失敗しました"
    end
    redirect_to root_path
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
