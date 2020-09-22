class ShoppingListHeaderComponent < ViewComponentReflex::Component
  def initialize(is_shopping_list_present, is_shopping_list_current, user)
    @is_shopping_list_present = is_shopping_list_present
    @is_shopping_list_current = is_shopping_list_current
    @user = user
  end

  def create_shopping_list
    @is_shopping_list_present = true
    @is_shopping_list_current = true
    scheduled_meals = ScheduledMeal.scheduled_meals_for_period(Date.today, Date.today+7, @user)
    scheduled_meals.each do |scheduled_meal|
      if scheduled_meal.meal.ingredients.count > 0
        scheduled_meal.meal.ingredients.each do |ingredient|
          ShoppingListItem.create(ingredient: ingredient, scheduled_meal: scheduled_meal, user: @user, acquired: false)
        end
      else
        ShoppingListItem.create(scheduled_meal: scheduled_meal, user: @user, acquired: false)
      end
    end
    refresh! '.shopping-list-details', selector
  end

  def update_shopping_list
    @is_shopping_list_present = true
    @is_shopping_list_current = true
    shopping_list_items = ShoppingListItem.items_for(@user)
    covered_scheduled_meal_ids = (shopping_list_items.map { |sli| sli.scheduled_meal_id }).uniq
    scheduled_meals = ScheduledMeal.scheduled_meals_for_period(Date.today, Date.today+7, @user)
    scheduled_meals.select { |sm| covered_scheduled_meal_ids.exclude? sm.id }
      .each do |scheduled_meal|
      if scheduled_meal.meal.ingredients.count > 0
        scheduled_meal.meal.ingredients.each do |ingredient|
          ShoppingListItem.create(ingredient: ingredient, scheduled_meal: scheduled_meal, user: @user, acquired: false)
        end
      else
        ShoppingListItem.create(scheduled_meal: scheduled_meal, user: @user, acquired: false)
      end
    end
    refresh! '.shopping-list-details', selector
  end

  def clear_shopping_list
    ShoppingListItem.items_for(@user).destroy_all
    refresh! '.shopping-list-details', selector
  end

end
