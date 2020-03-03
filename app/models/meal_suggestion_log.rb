class MealSuggestionLog < ApplicationRecord
  belongs_to :meal
  belongs_to :user
end
