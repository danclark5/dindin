class ShoppingListDetailsComponent < ViewComponentReflex::Component
  def initialize(user)
    @user = user
    @shopping_list_items = ShoppingListItem.items_for(@user).includes(:ingredient).includes(:scheduled_meal).order("ingredients.ingredient_category_id, ingredients.name, acquired")
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
