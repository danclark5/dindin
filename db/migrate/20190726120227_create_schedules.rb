class CreateSchedules < ActiveRecord::Migration[5.2]
  def change
    create_table :schedules do |t|
      t.date :start_date
      t.date :end_date
      t.boolean :include_breakfast
      t.boolean :include_lunch
      t.boolean :include_dinner
      t.integer :default_participant_count

      t.timestamps
    end
  end
end
