class AddUserReferences < ActiveRecord::Migration[5.2]
  def change
    add_reference :schedules, :user, foreign_key: true
    add_reference :scheduled_meals, :user, foreign_key: true
  end
end
