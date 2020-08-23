class AddRecipeUrl2ToMeals < ActiveRecord::Migration[6.0]
  def change
    remove_column :meals, :fieldname, :string
    add_column :meals, :recipe_url, :string
  end
end
