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

  def accessible_to_user?(user)
    self.user == user || self.user.nil?
  end

  def global?
    self.user.nil?
  end
end
