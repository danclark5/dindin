class ScheduledMeal < ApplicationRecord
  belongs_to :meal
  belongs_to :user

  scope :scheduled_meals_for, ->(user) {
    left_outer_joins(:user)
      .where("users.id = ? OR users.id is null", user.id)
  }

  def self.scheduled_meal_ids_for_period(start_date, end_date, user)
    scheduled_meals_for(user).where("date >= '#{start_date}' AND date <= '#{end_date}'").select("id")
  end

  def self.scheduled_meals_for_period(start_date, end_date, user)
    scheduled_meals_for(user).where("date >= '#{start_date}' AND date <= '#{end_date}'")
  end
end
