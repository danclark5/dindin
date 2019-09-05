class CreateScheduledMeals < ActiveRecord::Migration[5.2]
  def change
    create_table :scheduled_meals do |t|
      t.references :meal, foreign_key: true
      t.date :date
      t.references :meal_type, foreign_key: true

      t.timestamps
    end
  end
end
