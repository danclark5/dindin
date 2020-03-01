class ApplicationController < ActionController::Base
 before_action :configure_permitted_parameters, if: :devise_controller?

  def hello
    @upcoming_meals = lookup_upcoming_meals
    @suggested_meals = Meal.get_suggested_meals(3)
    @scheduled_meal = ScheduledMeal.new()
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:preferred_timezone, :email, :password)}
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:preferred_timezone, :email, :password, :current_password)}
  end
  private

  def lookup_upcoming_meals
    start_date = DateTime.now.in_time_zone(current_user.preferred_timezone)
    end_date = start_date + 2.days
    ScheduledMeal
      .joins(:meal)
      .joins("right join generate_series('#{start_date.strftime('%F')}', '#{end_date.strftime('%F')}', '1 day'::interval) as dates on dates = scheduled_meals.date and scheduled_meals.user_id = #{current_user.id}")
      .where("scheduled_meals.user_id = ? or scheduled_meals.user_id is null", current_user.id)
      .select("dates as schedule_date", :id, :meal_id, "meals.name as meal_name")
      .order(schedule_date: :asc)
  end
end
