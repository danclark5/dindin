class Meal < ApplicationRecord
  include PgSearch::Model

  validates :name, presence: true
  has_many :scheduled_meal
  has_and_belongs_to_many :users

  pg_search_scope :search, against: :name, using: {:tsearch => {:prefix => true}}
  scope :meals_for, ->(user) {
    left_outer_joins(:users)
    .where("users.id = ? OR users.id is null", user.id)
  }

  def self.get_suggested_meals(number_of_meals)
    left_joins(:scheduled_meal).group(:id).select(:id, :name).order("COUNT(scheduled_meals.meal_id) ASC").limit(number_of_meals).all.shuffle
  end
end
