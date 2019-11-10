class ScheduledMeal < ApplicationRecord
  belongs_to :meal
  belongs_to :schedule
end
