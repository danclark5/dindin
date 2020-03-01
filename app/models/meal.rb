class Meal < ApplicationRecord
  include PgSearch::Model

  attr_accessor :global_meal

  validates :name, presence: true
  has_many :scheduled_meals
  belongs_to :user, optional: true

  pg_search_scope :search, against: :name, using: {:tsearch => {:prefix => true}}
  scope :meals_for, ->(user) {
    left_outer_joins(:user)
      .where("users.id = ? OR users.id is null", user.id)
  }

  def self.get_suggested_meals(number_of_meals)
    left_joins(:scheduled_meals).group(:id).select(:id, :name).order("COUNT(scheduled_meals.meal_id) ASC").limit(number_of_meals).all.shuffle
  end

  def accessible_to_user?(user)
    self.user == user || self.user.nil?
  end
end
