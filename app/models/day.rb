class Day < ActiveRecord::Base
  has_many :habit_days
  has_many :habits, through: :habit_days
end
