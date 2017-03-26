class Achivement < ActiveRecord::Base
  belongs_to :habit
  has_one :memo

  scope :today_achivements, ->(user_id) {
    today_date = Time.zone.today
    #習慣が既に存在しない場合の達成は表示したくないのでinnerjoin
    #レコード数増大した時に遅くなると嫌なので、JOINさせずIN句でキャッシュ
    Achivement
      .joins(:habit).preload(:habit)
      .preload(:memo)
      .where(date: today_date)
      .where(habits: {user_id: user_id})
      .where("habits.start_date <= ? AND ? <= habits.end_date", today_date, today_date)
  }


end
