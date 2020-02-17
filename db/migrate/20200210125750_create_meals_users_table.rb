class CreateMealsUsersTable < ActiveRecord::Migration[5.2]
  def change
    drop_table :user_meals
    create_table :meals_users_tables do |t|
      t.belongs_to :user
      t.belongs_to :meal
    end
  end
end
