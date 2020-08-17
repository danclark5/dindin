class ManageMealIngredientsComponent <  ViewComponentReflex::Component
  def initialize(meal)
    @meal = meal
  end

  def add_ingredient
  end

  def remove_ingredient
    @meal = Meal.find(element.dataset[:meal_id])
    ingredient = @meal.ingredients.find(element.dataset[:ingredient_id])

    if ingredient
      @meal.ingredients.delete(ingredient)
    end
  end
end
