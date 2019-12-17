class RemoveScheduleRelationshipTake2 < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key :scheduled_meals, :schedules
  end
end
