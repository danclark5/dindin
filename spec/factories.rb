FactoryBot.define do
  factory :meal do
    name { "A meal" }
  end

  factory :schedule do
    start_date { 3.days.from_now }
    end_date { start_date + 6.days }
    default_participant_count { 2 }
  end

  factory :scheduled_meal do
    meal
    date { schedule.start_date }
    schedule
  end
end
