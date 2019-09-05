class AddFkToScheduledMeals < ActiveRecord::Migration[5.2]
  def change
    add_reference :scheduled_meals, :schedule, foreign_key: true
  end
end
