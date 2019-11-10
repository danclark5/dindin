class RemoveModelTypeJunk < ActiveRecord::Migration[5.2]
  def change
    remove_column :scheduled_meals, :meal_type_id
  end
end
