class ManageMealIngredientsComponent <  ViewComponentReflex::Component
  def initialize(meal, user)
    @meal = meal
    @user = user
  end

  def add_ingredient
    @meal = Meal.meals_for(@user).find(element.dataset[:meal_id])
    ingredient = Ingredient.find(element.dataset[:ingredient_id])
    @meal.ingredients << ingredient
  end

  def remove_ingredient
    @meal = Meal.meals_for(@user).find(element.dataset[:meal_id])
    ingredient = @meal.ingredients.find(element.dataset[:ingredient_id])

    if ingredient
      @meal.ingredients.delete(ingredient)
    end
  end

  def create_ingredient
    @meal = Meal.meals_for(@user).find(element.dataset[:meal_id])
    ingredient = Ingredient.create(name: element.dataset[:ingredient_term])
    if @user.user_type != 'admin'
      ingredient.user = @user
      ingredient.save
    end
    @meal.ingredients << ingredient
  end
end
