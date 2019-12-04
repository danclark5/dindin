require 'faker'
FactoryBot.define do

  factory :user do
    email { Faker::Internet.email }
    password { "password"}
    password_confirmation { "password" }
#    confirmed_at { Date.today }
  end

  factory :meal do
    name { "A meal" }
  end

  factory :schedule do
    start_date { 3.days.from_now }
    end_date { start_date + 6.days }
    default_participant_count { 2 }
    user
  end

  factory :scheduled_meal do
    meal
    date { schedule.start_date }
    schedule
    user
  end
end
