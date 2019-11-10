class DropMealTypes < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key :scheduled_meals, :meal_types
    drop_table :meal_types
  end
end
