class AddIngredientCategoryToIngredient < ActiveRecord::Migration[6.0]
  def change
    add_reference :ingredients, :ingredient_category, null: true, foreign_key: true
  end
end
