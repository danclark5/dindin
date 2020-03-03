class User < ApplicationRecord
  has_many :scheduled_meals
  has_many :meals
  has_many :meal_suggestion_logs
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
