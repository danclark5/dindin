# frozen_string_literal: true

class ScheduledMealsReflex < ApplicationReflex
  delegate :current_user, to: :connection
  def remove_scheduled_meal
    ScheduledMeal.find(element.dataset[:scheduled_meal_id].to_i).destroy
  end
end
