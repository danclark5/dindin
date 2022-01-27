# frozen_string_literal: true

class ScheduledMealsReflex < ApplicationReflex
  delegate :current_user, to: :connection
  def remove_scheduled_meal
    ScheduledMeal.where(id: element.dataset[:scheduled_meal_id].to_i, user_id: current_user).first.destroy
    meal_suggestions = MealSchedule.new(user: current_user).suggest_meals(1)
    morph element.dataset[:reflex_root] + "_actual", render(SuggestedMealComponent.new(meal_suggestions, element.dataset[:date]))
  end

  def push_scheduled_meal
  end
end
