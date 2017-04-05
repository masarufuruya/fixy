class Habit < ActiveRecord::Base
  has_many :achivements, dependent: :destroy
  has_many :habit_days, dependent: :destroy
  has_many :memos, dependent: :destroy
  has_many :days, through: :habit_days
  belongs_to :user

  validate :limit_habit_period

  scope :doing_habits, ->(user_id) {
    today_date = Time.zone.today
    #JOINさせたくない場合にN+1対策するならpreload
    #INNERJOINにするとメモが0件の習慣がでなくなるのでLEFTJOIN
    #レコード多くてOrderするようなSQLは1件のSQLにすると遅いのでpreloadで分割した方が早い
    Habit
      .preload(:memos)
      .eager_load(:achivements)
      .where(habits: {user_id: user_id})
      .where("habits.start_date <= ? AND ? <= habits.end_date", today_date, today_date)
      .order("achivements.date asc")
  }

  scope :completed_habits, ->(user_id) {
    today_date = Time.zone.today
    Habit
      .preload(:memos)
      .eager_load(:achivements)
      .where(habits: {user_id: user_id})
      .where("habits.end_date < ?", today_date)
      .order("achivements.date asc")
  }

  #期間に上限を設ける
  def limit_habit_period
    max_period = 1.weeks
    if start_date < (end_date - max_period)
      errors.add(:start_date, "取り組む習慣の期間は最大1週間に設定しましょう")
    elsif Time.zone.today < start_date
      errors.add(:start_date, "未来の日付は指定できません")
    end
  end

  def achivement_rate
    completed_count = achivements.select { |achivement| achivement.completed == true }.count
    # 基本の３メソッド
    # * count - 単発 = 呼ばれる都度 COUNT SQLを発行
    # * size - 日和見 = キャッシュがあればキャッシュを数える。キャッシュがなければcount
    # * length - 蓄える = キャッシュがなければキャッシュして数える
    #
    # その他のメソッド
    # * empty?, any? - size の仲間
    # * exists? - count の仲間
    # * blank?, present?, none? - length の仲間
    (completed_count.to_f / achivements.size * 100).round(2)
  end

  def create_habit_achivements(checked_day_ids)
    # 取得時は競合せず保存時に競合を確認する(楽観的ロック) rescue ActiveRecord::StaleObjectError
    # バリデーションエラーとそれ以外のDB通信等のエラーの内容を分ける
    begin
      ActiveRecord::Base.transaction do
        #ここの保存が失敗する
        self.save!
        create_habit_days(checked_day_ids)
        create_achivements(checked_day_ids)
      end
      return {error: ''}
    rescue ActiveRecord::RecordInvalid => e
      return {error: e.record.errors.full_messages}
    rescue => e
      return {error: ['失敗しました']}
    end
  end

  private

    def create_habit_days(day_ids)
      day_ids.each do |day_id|
        if HabitDay.exists?(habit_id: id, day_id: day_id)
          next
        end
        HabitDay.create!(habit_id: id, day_id: day_id, checked: true)
      end
    end

    def create_achivements(day_ids)
      #Date.parseは文字列をparseしてYYYY/MM/DDのDateにする(タイムゾーンは関係しない)
      #作成した習慣の指定曜日分のレコードを作成
      (start_date..end_date).each do |target_date|
        target_day_id = target_date.wday + 1
        if Achivement.exists?(habit_id: id, date: target_date)
          next
        end
        if day_ids.include?(target_day_id.to_s)
          Achivement.create!(habit_id: id, date: target_date)
        end
      end
    end
end
