class Meal < ApplicationRecord
  validates :name, presence: true
  has_many :scheduled_meal
  def self.get_suggested_meals(number_of_meals)
    left_joins(:scheduled_meal).group(:id).select(:id, :name).order("COUNT(scheduled_meals.meal_id) ASC").limit(number_of_meals).all.shuffle
  end
end
