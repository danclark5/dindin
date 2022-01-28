class MealReflex < StimulusReflex::Reflex
  delegate :current_user, to: :connection

  def attach_suggested_meal
    scheduled_meal = ScheduledMeal.new(meal_id: element.dataset[:meal_id].to_i, date: element.dataset[:date], user: current_user)
    scheduled_meal.save
    scheduled_date = Date.parse(element.dataset[:date])
    morph element.dataset[:reflex_root], render(ScheduledMealComponent.new(scheduled_meal, scheduled_date))
  end

  def reload_suggested_meal
    meal_suggestions = MealSchedule.new(user: current_user).suggest_meals(3)
    scheduled_date = Date.parse(element.dataset[:date])
    morph element.dataset[:reflex_root], render(SuggestedMealComponent.new(meal_suggestions, scheduled_date))
  end

  def add_ingredient
    @meal = Meal.meals_for(current_user).find(element.dataset[:meal_id])
    if element.dataset[:ingredient_id] != "0"
      ingredient = Ingredient.find(element.dataset[:ingredient_id])
    elsif element.dataset[:ingredient_term].length > 0
      if current_user.user_type != 'admin'
        user_id = current_user.id
      else
        user_id = nil
      end
      ingredient = Ingredient.find_or_create_by(name: element.dataset[:ingredient_term].titleize,
                                             user_id: user_id)
    end
    if ingredient.ingredient_category&.id == USER_ITEM.id
      ingredient.ingredient_category = nil
      ingredient.save
    end
    @meal.ingredients << ingredient
  end

  def remove_ingredient
    @meal = Meal.meals_for(current_user).find(element.dataset[:meal_id])
    ingredient = @meal.ingredients.find(element.dataset[:ingredient_id])

    if ingredient
      @meal.ingredients.delete(ingredient)
    end
  end
end
