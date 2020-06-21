class LandingController < ApplicationController
  def index
    @upcoming_meals = lookup_upcoming_meals
    @suggested_meals = Meal.get_suggested_meals(3, current_user)
    @scheduled_meal = ScheduledMeal.new()
  end

  private

  def lookup_upcoming_meals(start_date: nil)
    start_date = DateTime.now.in_time_zone(current_user.preferred_timezone) unless start_date
    end_date = start_date + 2.days
    ScheduledMeal
      .joins(:meal)
      .joins("right join generate_series('#{start_date.strftime('%F')}', '#{end_date.strftime('%F')}', '1 day'::interval) as dates on dates = scheduled_meals.date and scheduled_meals.user_id = #{current_user.id}")
      .where("scheduled_meals.user_id = ? or scheduled_meals.user_id is null", current_user.id)
      .select("dates as schedule_date", :id, :meal_id, "meals.name as meal_name")
      .order(schedule_date: :asc)
  end
end
