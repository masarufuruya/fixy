desc '今日予定している習慣を伝えるメールを送信する'
#DBアクセスにenvironmentが必要
task send_daily_habits_email: :environment do
  #TODO: 退会フラグ等でフィルタリング出来るようにする
  users = User.all
  users.each do |user|
    UserMailer.today_habit_email(user).deliver_now
  end
end
