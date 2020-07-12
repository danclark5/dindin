class IngredientCategory < ApplicationRecord
  validates :name, presence: true
end
