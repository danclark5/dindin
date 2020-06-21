class LandingController < ApplicationController
  def index
    upcoming_meals = lookup_upcoming_meals
    suggested_meals = Meal.get_suggested_meals(3, current_user)
    @scheduled_meal = ScheduledMeal.new()
    @meals= upcoming_meals.zip suggested_meals
    @past_start_date = (relevant_start_date - 3.days).strftime('%F')
    @future_start_date = (relevant_start_date + 3.days).strftime('%F')
  end

  private

  def lookup_upcoming_meals
    end_date = relevant_start_date + 2.days
    ScheduledMeal
      .joins(:meal)
      .joins("right join generate_series('#{relevant_start_date.strftime('%F')}', '#{end_date.strftime('%F')}', '1 day'::interval) as dates on dates = scheduled_meals.date and scheduled_meals.user_id = #{current_user.id}")
      .where("scheduled_meals.user_id = ? or scheduled_meals.user_id is null", current_user.id)
      .select("dates as schedule_date", :id, :meal_id, "meals.name as meal_name")
      .order(schedule_date: :asc)
  end

  def relevant_start_date
    return DateTime.parse(params[:start_date]) if params.include? :start_date
    DateTime.now.in_time_zone(current_user.preferred_timezone)
  end
end
