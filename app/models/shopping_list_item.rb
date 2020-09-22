class ShoppingListItem < ApplicationRecord
  belongs_to :user
  belongs_to :ingredient, optional: true
  belongs_to :scheduled_meal, optional: true

  scope :items_for, ->(user) {
    left_outer_joins(:user)
      .where("users.id = ? OR users.id is null", user.id)
  }

  
end
