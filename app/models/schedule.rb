class Schedule < ApplicationRecord
  validates :start_date, :end_date, :default_participant_count, presence: true
  validate :start_date_before_end_date

  has_many :scheduled_meals

  def included_dates
    (self.start_date..self.end_date).to_a
  end

  def meal_for date
    self.scheduled_meals.select { |scheduled_meal| scheduled_meal.date == date}.first
  end

  def start_date_before_end_date
    if start_date.present? && end_date < start_date
      errors.add(:end_date, "must be after start date")
    end
  end
end
