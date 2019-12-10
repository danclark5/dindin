class ApplicationController < ActionController::Base
  def hello
    @upcoming_meals = lookup_upcoming_meals
    @suggested_meals = Meal.get_suggested_meals(3)
    @scheduled_meal = ScheduledMeal.new()
  end

  private

  def lookup_upcoming_meals
    ScheduledMeal.where(user: current_user)
      .where(date: (Time.now.midnight)..Time.now.midnight + 2.day)
  end
end
