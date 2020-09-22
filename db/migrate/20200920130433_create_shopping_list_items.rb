class CreateShoppingListItems < ActiveRecord::Migration[6.0]
  def change
    create_table :shopping_list_items do |t|
      t.references :user, null: false, foreign_key: true
      t.references :ingredient, null: true, foreign_key: true
      t.references :scheduled_meal, null: true, foreign_key: true
      t.boolean :acquired

      t.timestamps
    end
  end
end
