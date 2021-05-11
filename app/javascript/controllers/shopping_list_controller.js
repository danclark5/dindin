import ApplicationController from './application_controller'
import { Controller } from 'stimulus'
import StimulusReflex from 'stimulus_reflex'

export default class extends ApplicationController {

  clear(event, response) {
    event.preventDefault()
    if (event["detail"][0]) this.stimulate('ShoppingList#clear', event.target)
  }

  delete_item(event, response) {
    event.preventDefault()
    if (event["detail"][0]) this.stimulate('ShoppingList#delete', event.target)
  }

  finalizeReflex(anchorElement) {
    document.getElementById('ingredient').value = "";
    document.getElementById('add-ingredient-button').setAttribute('data-ingredient_id', "");
    document.getElementById('add-ingredient-button').setAttribute('data-ingredient_term', "");
  }
}
