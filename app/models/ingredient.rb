class Ingredient < ApplicationRecord
  validates :name, presence: true

  belongs_to :ingredient_category, optional: true
end
