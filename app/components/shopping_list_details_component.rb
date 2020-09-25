class ShoppingListDetailsComponent < ViewComponentReflex::Component
  def initialize(user)
    @user = user
    @shopping_list_items = ShoppingListItem.items_for(@user).order(:acquired)
  end

  def add_ingredient
    if element.dataset[:ingredient_id] != "0"
      ingredient = Ingredient.find(element.dataset[:ingredient_id])
    else
      ingredient = Ingredient.create(name: element.dataset[:ingredient_term].titleize)
      if @user.user_type != 'admin'
        ingredient.user = @user
        ingredient.save
      end
    end
    ShoppingListItem.create(ingredient: ingredient, user: @user, acquired: false) if ingredient
    refresh! '.shopping-list-details', selector
    refresh! '#shopping-list-header', selector
  end
end
