class ManageMealIngredientsComponent <  ViewComponentReflex::Component
  def initialize(meal, user)
    @meal = meal
    @user = user
  end

  def add_ingredient
    @meal = Meal.meals_for(@user).find(element.dataset[:meal_id])
    if element.dataset[:ingredient_id] != "0"
      ingredient = Ingredient.find(element.dataset[:ingredient_id])
    else
      ingredient = Ingredient.create(name: element.dataset[:ingredient_term].titleize)
      if @user.user_type != 'admin'
        ingredient.user = @user
        ingredient.save
      end
    end
    @meal.ingredients << ingredient
  end

  def remove_ingredient
    @meal = Meal.meals_for(@user).find(element.dataset[:meal_id])
    ingredient = @meal.ingredients.find(element.dataset[:ingredient_id])

    if ingredient
      @meal.ingredients.delete(ingredient)
    end
  end
end
