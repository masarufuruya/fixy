class UserMailer < ApplicationMailer
  default from: "fixy@example.com"

  def today_habit_email(user)
    @today_habits = Achivement.today_achivements(user.id)
    if @today_habits.present?
      @url = root_url
      mail(to: user.email, subject: "Today Habit")
    end
  end
end
