# frozen_string_literal: true

class ScheduledMealsReflex < ApplicationReflex
  delegate :current_user, to: :connection
  def remove
    ScheduledMeal.where(id: element.dataset[:scheduled_meal_id].to_i, user_id: current_user).first.destroy
    meal_suggestions = MealSchedule.new(user: current_user).suggest_meals(1)
    morph element.dataset[:reflex_root], render(SuggestedMealComponent.new(meal_suggestions, Date.parse(element.dataset[:date])))
  end

  def push_out
    as_of_date = Date.strptime(element.dataset[:date])
    schedule = MealSchedule.new(user: current_user)
    schedule.push_out(as_of_date: as_of_date)
    @meal_schedule = schedule.generate(from_date: relevant_start_date, days: 3)
    @past_start_date = (relevant_start_date - 3.days).strftime('%F')
    @future_start_date = (relevant_start_date + 3.days).strftime('%F')
  end

  private def relevant_start_date
    return Date.parse(params[:start_date]) if params.include? :start_date
    Time.now.in_time_zone(current_user.preferred_timezone).to_date
  end

  def push_scheduled_meal
  end
end
