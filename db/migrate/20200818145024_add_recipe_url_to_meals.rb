class AddRecipeUrlToMeals < ActiveRecord::Migration[6.0]
  def change
    add_column :meals, :fieldname, :string
  end
end
