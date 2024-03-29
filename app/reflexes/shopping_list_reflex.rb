class ShoppingListReflex < StimulusReflex::Reflex
  delegate :current_user, to: :connection
  def create
    scheduled_meals = ScheduledMeal.scheduled_meals_for_period(Date.today, Date.today+7, current_user)
    scheduled_meals.each do |scheduled_meal|
      if scheduled_meal.meal.ingredients.count > 0
        scheduled_meal.meal.ingredients.each do |ingredient|
          ShoppingListItem.create(ingredient: ingredient, scheduled_meal: scheduled_meal, user_id: current_user.id, acquired: false)
        end
      else
        ShoppingListItem.create(scheduled_meal: scheduled_meal, user_id: current_user.id, acquired: false)
      end
    end
    #@shopping_list_end_date = get_shopping_list_end_date
  end

  def clear
    ShoppingListItem.items_for(current_user).destroy_all
    @shopping_list_end_date = nil
  end

  def reset_snoozes
    ShoppingListItem.items_for(current_user).each do |item|
      item.snooze_until = nil
      item.save
    end
  end

  def toggle_item
    #TODO: validate against user
    shopping_list_item = ShoppingListItem.find(element.dataset[:item_id])
    shopping_list_item.acquired = !shopping_list_item.acquired
    shopping_list_item.save
  end

  def snooze
    #TODO: validate against user
    shopping_list_item = ShoppingListItem.find(element.dataset[:item_id])
    snooze_until = element.dataset[:hours].to_i.hours.from_now
    shopping_list_item.snooze_until = snooze_until
    shopping_list_item.save
  end

  def delete
    #TODO: validate against user
    @shopping_list_item = ShoppingListItem.find(element.dataset[:item_id])
    @shopping_list_item.destroy
  end

  def add_ingredient
    if element.dataset[:ingredient_id] != "0"
      ingredient = Ingredient.find(element.dataset[:ingredient_id])
    elsif element.dataset[:ingredient_term].length > 0
      if User.find(current_user.id).user_type != 'admin'
        user_id = current_user.id
      else
        user_id = nil
      end
      ingredient = Ingredient.find_or_create_by(name: element.dataset[:ingredient_term].titleize,
                                             ingredient_category_id: USER_ITEM.id,
                                             user_id: current_user.id)
    end
    ShoppingListItem.create(ingredient: ingredient, user_id: current_user.id, acquired: false) if ingredient
  end
end
