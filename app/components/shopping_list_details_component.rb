class ShoppingListDetailsComponent < ViewComponentReflex::Component
  def initialize(user)
    @user = user
    @shopping_list_items = ShoppingListItem.items_for(@user).
      includes(:ingredient).
      includes(:scheduled_meal).
      order("ingredients.ingredient_category_id, ingredients.name")
  end

end
