class ShoppingListItemComponent < ViewComponentReflex::Component
  def initialize(shopping_list_item:)
    @shopping_list_item = shopping_list_item
  end

  def collection_key
    @shopping_list_item.id
  end

  def toggle_item
    @shopping_list_item.acquired = !@shopping_list_item.acquired
    @shopping_list_item.save
  end
end
