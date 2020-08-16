class Ingredient < ApplicationRecord
  include PgSearch::Model

  validates :name, presence: true

  belongs_to :ingredient_category, optional: true
  belongs_to :user, optional: true

  pg_search_scope :ingredient_search, against: :name, using: {:tsearch => {:prefix => true}}
  scope :ingredients_for, ->(user) {
    left_outer_joins(:user)
      .where("users.id = ? OR users.id is null", user.id)
  }
end
