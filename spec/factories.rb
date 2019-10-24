FactoryBot.define do
  factory :meal do
    name { "A meal" }
  end

  factory :meal_type do
    description { "Dinner" }
  end

  factory :schedule do
    start_date { 3.days.from_now }
    end_date { start_date + 6.days }
    include_breakfast { false }
    include_lunch { true }
    include_dinner { true }
    default_participant_count { 2 }
  end

  factory :scheduled_meal do
    meal
    date { schedule.start_date }
    meal_type
    schedule
  end
end
