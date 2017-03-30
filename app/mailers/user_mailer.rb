class UserMailer < ApplicationMailer
  default from: "fixy@example.com"

  def today_habit_email(user)
    @today_habits = Achivement.today_achivements(user.id)
    @url = root_path
    mail(to: user.email, subject: "Today Habit")
  end
end
