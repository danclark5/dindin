import ApplicationController from './application_controller'
import { Controller } from 'stimulus'
import StimulusReflex from 'stimulus_reflex'

export default class extends ApplicationController {

  afterReflex(anchorElement) {
    console.log("after shopping list details hehehe");
  }

  finalizeReflex(anchorElement) {
    console.log("finalize shopping list details hehehe");
  }
}
