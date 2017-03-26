class TodayHabitsController < ApplicationController
  before_filter :authenticate_user

  def index
    @achivements = Achivement.today_achivements(current_user.id)
  end
end
