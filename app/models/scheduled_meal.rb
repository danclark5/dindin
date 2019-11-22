class ScheduledMeal < ApplicationRecord
  belongs_to :meal
  belongs_to :schedule
  belongs_to :user
end
