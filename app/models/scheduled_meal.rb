class ScheduledMeal < ApplicationRecord
  belongs_to :meal
  belongs_to :user

  has_many :shopping_list_items, dependent: :destroy

  scope :scheduled_meals_for, ->(user_id) {
    left_outer_joins(:user)
      .where("users.id = ? OR users.id is null", user_id)
  }

  def self.scheduled_meal_ids_for_period(start_date, end_date, user_id)
    scheduled_meals_for(user_id).where("date >= '#{start_date}' AND date <= '#{end_date}'").select("id")
  end

  def self.scheduled_meals_for_period(start_date, end_date, user_id)
    scheduled_meals_for(user_id).where("date >= '#{start_date}' AND date <= '#{end_date}'")
  end

  def swap_meal(other_meal)
    raise MealSwapProhibited if self.user != other_meal.user
    other_meals_date = other_meal.date
    other_meal.date = self.date
    other_meal.save
    self.date = other_meals_date
    self.save
  end
end

class MealSwapProhibited < StandardError
end
