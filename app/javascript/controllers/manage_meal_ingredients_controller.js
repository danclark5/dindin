import ApplicationController from './application_controller'
import { Controller } from 'stimulus'
import StimulusReflex from 'stimulus_reflex'


export default class extends ApplicationController {
  connect () {
    StimulusReflex.register(this)
  }

  afterReflex(anchorElement) {
    document.getElementById('ingredient').value = "";
    document.getElementById('add-ingredient-button').setAttribute('data-ingredient_id', "");
    document.getElementById('add-ingredient-button').setAttribute('data-ingredient_term', "");
  }
}
