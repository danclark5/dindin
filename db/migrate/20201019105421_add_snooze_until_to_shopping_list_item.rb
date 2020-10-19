class AddSnoozeUntilToShoppingListItem < ActiveRecord::Migration[6.0]
  def change
    add_column :shopping_list_items, :snooze_until, :datetime
  end
end
