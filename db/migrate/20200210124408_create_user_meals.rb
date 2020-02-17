class CreateUserMeals < ActiveRecord::Migration[5.2]
  def change
    create_table :user_meals do |t|
      t.belongs_to :user
      t.belongs_to :meal
      t.timestamps
    end
  end
end
