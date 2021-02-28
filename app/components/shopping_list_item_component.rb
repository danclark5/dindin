class ShoppingListItemComponent < ViewComponentReflex::Component
  def initialize(shopping_list_item:)
    @shopping_list_item_id = shopping_list_item.id
    @snoozed = (shopping_list_item.snooze_until && shopping_list_item.snooze_until > DateTime.current)
  end

  def collection_key
    @shopping_list_item_id
  end

  def toggle_item
    shopping_list_item = ShoppingListItem.find(@shopping_list_item_id)
    shopping_list_item.acquired = !shopping_list_item.acquired
    shopping_list_item.save
  end

  def delete
    shopping_list_item = ShoppingListItem.find(@shopping_list_item_id)
    shopping_list_item.destroy
  end

  def snooze
    shopping_list_item = ShoppingListItem.find(@shopping_list_item_id)
    snooze_until = element.dataset[:hours].to_i.hours.from_now
    shopping_list_item.snooze_until = snooze_until
    shopping_list_item.save
    @snoozed = true
  end
end
