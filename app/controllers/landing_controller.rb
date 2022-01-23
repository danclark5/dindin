require 'meal_schedule.rb'

class LandingController < ApplicationController
  def index
    @meal_schedule = MealSchedule.upcoming_meals_and_suggestions(days: 3, from_date: relevant_start_date, user: current_user)
    @past_start_date = (relevant_start_date - 3.days).strftime('%F')
    @future_start_date = (relevant_start_date + 3.days).strftime('%F')
  end

  private

  def relevant_start_date
    return DateTime.parse(params[:start_date]) if params.include? :start_date
    DateTime.now.in_time_zone(current_user.preferred_timezone)
  end
end
