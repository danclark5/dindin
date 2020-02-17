class CreateMealsUsersTable2 < ActiveRecord::Migration[5.2]
  def change
    drop_table :meals_users_tables
    create_table :meals_users do |t|
      t.belongs_to :user
      t.belongs_to :meal
    end
  end
end
