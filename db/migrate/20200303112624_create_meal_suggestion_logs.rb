class CreateMealSuggestionLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :meal_suggestion_logs do |t|
      t.references :meal, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
