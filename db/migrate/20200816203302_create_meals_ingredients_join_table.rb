class CreateMealsIngredientsJoinTable < ActiveRecord::Migration[6.0]
  def change
    create_join_table :meals, :ingredients do |t|
      t.index :meal_id
      t.index :ingredient_id
    end
  end
end
