class ChangeNameToNotNullInMeal < ActiveRecord::Migration[5.2]
  def change
    change_column :meals, :name, :string, null: false
  end
end
