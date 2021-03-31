class ShoppingListsController < ApplicationController
  def show
    @shopping_list_items = ShoppingListItem.items_for(current_user.id)
    @shopping_list_end_date = get_shopping_list_end_date
    @is_shopping_list_present = @shopping_list_items.count > 0
    @is_shopping_list_current = (covered_scheduled_meals & current_scheduled_meals).sort == current_scheduled_meals.sort
  end

  private
  def covered_scheduled_meals
    @shopping_list_items.map { |sli| sli.scheduled_meal_id }
  end

  def current_scheduled_meals
    ScheduledMeal.scheduled_meal_ids_for_period(Date.today, Date.today+7, current_user.id).map { |csm| csm.id }
  end

  def get_shopping_list_end_date
    (@shopping_list_items.max_by { |sli| sli&.scheduled_meal&.date || Date.today }.scheduled_meal&.date || Date.today) if @shopping_list_items.any?
  end
end
