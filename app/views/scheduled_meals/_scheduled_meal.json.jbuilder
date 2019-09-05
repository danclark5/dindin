json.extract! scheduled_meal, :id, :meal_id, :date, :meal_type_id, :created_at, :updated_at
json.url scheduled_meal_url(scheduled_meal, format: :json)
