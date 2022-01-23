# frozen_string_literal: true

class ScheduledMealsReflex < ApplicationReflex
  delegate :current_user, to: :connection
  def remove_scheduled_meal
    ScheduledMeal.where(id: element.dataset[:scheduled_meal_id].to_i, user_id: current_user).first.destroy
    suggested_meal = MealSchedule.suggest_meals(1, current_user).first
    morph element.dataset[:reflex_root] + "_actual", render(SuggestedMealComponent.new(suggested_meal, element.dataset[:date]))
  end
end
