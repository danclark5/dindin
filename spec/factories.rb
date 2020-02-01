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

  factory :scheduled_meal do
    meal
    date { Date.today }
    user
  end
end
