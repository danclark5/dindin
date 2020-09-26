class ManageMealIngredientsComponent <  ViewComponentReflex::Component
  def initialize(meal, user)
    @meal = meal
    @user = user
  end

  def add_ingredient
    @meal = Meal.meals_for(@user).find(element.dataset[:meal_id])
    if element.dataset[:ingredient_id] != "0"
      ingredient = Ingredient.find(element.dataset[:ingredient_id])
    elsif element.dataset[:ingredient_term].length > 0
      if @user.user_type != 'admin'
        user_id = @user.id
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
    @meal = Meal.meals_for(@user).find(element.dataset[:meal_id])
    ingredient = @meal.ingredients.find(element.dataset[:ingredient_id])

    if ingredient
      @meal.ingredients.delete(ingredient)
    end
  end
end
