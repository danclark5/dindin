class ShoppingListDetailsComponent < ViewComponentReflex::Component
  def initialize(user)
    @user = user
    @shopping_list_items = ShoppingListItem.items_for(@user).order(:acquired)
  end
end
