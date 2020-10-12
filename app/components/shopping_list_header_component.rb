class ShoppingListHeaderComponent < ViewComponentReflex::Component
  def initialize(is_shopping_list_present, is_shopping_list_current, user)
    @is_shopping_list_present = is_shopping_list_present
    @is_shopping_list_current = is_shopping_list_current
    @user = user
    @shopping_list_end_date = get_shopping_list_end_date
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
    @shopping_list_end_date = get_shopping_list_end_date
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
    @shopping_list_end_date = get_shopping_list_end_date
    refresh! '.shopping-list-details', selector
  end

  def clear_shopping_list
    ShoppingListItem.items_for(@user).destroy_all
    @shopping_list_end_date = nil
    refresh! '.shopping-list-details', selector
  end

  def get_shopping_list_end_date
    shopping_list_items = ShoppingListItem.items_for(@user)
    (shopping_list_items.max_by { |sli| sli&.scheduled_meal&.date || Date.today }.scheduled_meal&.date || Date.today) if shopping_list_items.any?
  end

  def add_ingredient

    if element.dataset[:ingredient_id] != "0"
      ingredient = Ingredient.find(element.dataset[:ingredient_id])
    elsif element.dataset[:ingredient_term].length > 0
      if @user.user_type != 'admin'
        user_id = @user.id
      else
        user_id = nil
      end
      ingredient = Ingredient.find_or_create_by(name: element.dataset[:ingredient_term].titleize,
                                             ingredient_category_id: USER_ITEM.id,
                                             user_id: user_id)
    end
    ShoppingListItem.create(ingredient: ingredient, user: @user, acquired: false) if ingredient
    refresh! '.shopping-list-details', selector
    refresh! '#shopping-list-header', selector
  end

end
