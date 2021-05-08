class ShoppingListDetailsComponent < ViewComponentReflex::Component
  def initialize(user)
    @user_id = user.id
    @shopping_list_items = ShoppingListItem.items_for(@user_id).
      includes(:ingredient).
      includes(:scheduled_meal).
      order("ingredients.ingredient_category_id, ingredients.name")
    @sort_by = "meal"
  end

  def sort_shopping_list
    if element.dataset[:sort_by] == "meal"
      @shopping_list_items = ShoppingListItem.items_for(@user_id).
        includes(:ingredient).
        includes(:scheduled_meal).
        order("scheduled_meals.date, ingredients.name")
      @sort_by = "category"
    else
      @shopping_list_items = ShoppingListItem.items_for(@user_id).
        includes(:ingredient).
        includes(:scheduled_meal).
        order("ingredients.ingredient_category_id, ingredients.name")
      @sort_by = "meal"
    end
  end
end
