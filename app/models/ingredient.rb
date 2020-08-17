class Ingredient < ApplicationRecord
  include PgSearch::Model

  attr_accessor :global_ingredient

  validates :name, presence: true

  belongs_to :ingredient_category, optional: true
  belongs_to :user, optional: true
  has_and_belongs_to_many :meals

  pg_search_scope :ingredient_search, against: :name, using: {:tsearch => {:prefix => true}}
  scope :ingredients_for, ->(user) {
    left_outer_joins(:user)
      .where("users.id = ? OR users.id is null", user.id)
  }

  def global?
    self.user.nil?
  end
end
