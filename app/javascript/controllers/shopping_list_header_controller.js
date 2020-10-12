import ApplicationController from './application_controller'
import { Controller } from 'stimulus'
import StimulusReflex from 'stimulus_reflex'

export default class extends ApplicationController {

  clear_shopping_list(event, response) {
    event.preventDefault()
    if (event["detail"][0]) this.stimulate('ShoppingListHeaderComponent#clear_shopping_list', event.target)
  }

  remove_shopping_list_item(event, response) {
    event.preventDefault()
    if (event["detail"][0]) this.stimulate('ShoppingListItemComponent#delete', event.target)
  }

  afterReflex(anchorElement) {
    document.getElementById('ingredient').value = "";
    document.getElementById('add-ingredient-button').setAttribute('data-ingredient_id', "");
    document.getElementById('add-ingredient-button').setAttribute('data-ingredient_term', "");
  }
}
