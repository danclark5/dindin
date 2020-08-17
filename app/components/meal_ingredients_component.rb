class MealIngredientsComponent < ViewComponent::Base
  def initialize(meal)
    @ingredients = meal.ingredients 
  end
end
