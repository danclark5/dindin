class ManageMealIngredientsComponent <  ViewComponentReflex::Component
  def initialize(meal)
    @ingredients = meal.ingredients 
  end

  def add_ingredient
  end

  def remove_ingredient
    puts "YOLOLOLOLOL"
  end
end
