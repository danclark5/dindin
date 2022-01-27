require 'meal_schedule.rb'

class LandingController < ApplicationController
  def index
    @meal_schedule = MealSchedule.new(user: current_user).generate(from_date: relevant_start_date, days: 3)
    @past_start_date = (relevant_start_date - 3.days).strftime('%F')
    @future_start_date = (relevant_start_date + 3.days).strftime('%F')
  end

  private

  def relevant_start_date
    return Date.parse(params[:start_date]) if params.include? :start_date
    Time.now.in_time_zone(current_user.preferred_timezone).to_date
  end
end
