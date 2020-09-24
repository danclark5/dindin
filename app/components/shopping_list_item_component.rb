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
    refresh! '.shopping-list-details', selector
  end

  def delete
    @shopping_list_item.destroy
    refresh! '.shopping-list-details', selector
  end
end
