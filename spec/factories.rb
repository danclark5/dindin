require 'faker'
FactoryBot.define do

  factory :user do
    email { Faker::Internet.email }
    password { "password"}
    password_confirmation { "password" }
    user_type { 'free' }

    trait :admin do
      user_type { 'admin' }
    end

    factory :user_with_meal do
      after(:create) do |user|
        create(:meal, name: "User Meal", users: [user])
      end
    end
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
