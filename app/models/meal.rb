class Meal < ApplicationRecord
  include PgSearch::Model

  attr_accessor :global_meal

  validates :name, presence: true
  has_many :scheduled_meals, dependent: :destroy
  has_many :meal_suggestion_logs, dependent: :destroy
  has_and_belongs_to_many :ingredients
  belongs_to :user, optional: true
  has_and_belongs_to_many :tags, dependent: :destroy

  pg_search_scope :search, against: :name, using: {:tsearch => {:prefix => true}}
  scope :meals_for, ->(user) {
    left_outer_joins(:user)
      .where("users.id = ? OR users.id is null", user.id)
  }

  def self.get_suggested_meals(number_of_meals, user)
    meals = meals_for(user).
      joins("left join scheduled_meals on scheduled_meals.meal_id = meals.id and scheduled_meals.user_id = #{user.id}").
      joins("left join meal_suggestion_logs on meal_suggestion_logs.meal_id = meals.id and meal_suggestion_logs.user_id = #{user.id}").
      group(:id).
      select(:id, :name).
      order("(COUNT(scheduled_meals.meal_id) + COUNT(meal_suggestion_logs.meal_id) + random()*10) ASC").
      limit(number_of_meals).all.shuffle

    MealSuggestionLog.create(meals.map { |meal| {meal_id: meal.id, user_id: user.id} })
    meals
  end

  def accessible_to_user?(user)
    self.user == user || self.user.nil?
  end

  def global?
    self.user.nil?
  end
end
