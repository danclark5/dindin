class ScheduledMeal < ApplicationRecord
  belongs_to :meal
  belongs_to :meal_type
  belongs_to :schedule
end
