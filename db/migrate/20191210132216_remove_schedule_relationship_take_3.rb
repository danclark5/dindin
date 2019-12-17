class RemoveScheduleRelationshipTake3 < ActiveRecord::Migration[5.2]
  def change
    remove_column :scheduled_meals, :schedule_id, :integer
  end
end
