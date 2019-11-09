class Schedule < ApplicationRecord
  validates :start_date, :end_date, :default_participant_count, presence: true
  validates_inclusion_of :include_breakfast, :include_lunch, :include_dinner, in: [true, false]

  has_many :scheduled_meals

  def included_dates
    (self.start_date..self.end_date).to_a
  end

  def meal_for date, meal_type
    self.scheduled_meals.select { |scheduled_meal| scheduled_meal.date == date && scheduled_meal.meal_type.id == meal_type }.first
  end
end
