class MealReflex < StimulusReflex::Reflex
  delegate :current_user, to: :connection
  def attach_suggested_meal
    @scheduled_meal = ScheduledMeal.new(meal_id: element.dataset[:meal_id].to_i, date: element.dataset[:date])
    @scheduled_meal.user = current_user
    @scheduled_meal.save
  end

  def reload_suggested_meal
  end
end
