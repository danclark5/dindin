class AddVisualFieldsToIngredientCategories < ActiveRecord::Migration[6.0]
  def change
    add_column :ingredient_categories, :icon_identifier, :string
    add_column :ingredient_categories, :accent_color, :string
  end
end
