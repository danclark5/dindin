import ApplicationController from './application_controller'
import { Controller } from 'stimulus'
import StimulusReflex from 'stimulus_reflex'


/* This is the custom StimulusReflex controller for ScheduledMealsReflex.
 * Learn more at: https://docs.stimulusreflex.com
 */
export default class extends ApplicationController {

  /* Reflex specific lifecycle methods.
   * Use methods similar to this example to handle lifecycle concerns for a specific Reflex method.
   * Using the lifecycle is optional, so feel free to delete these stubs if you don't need them.
   *
   * Example:
   *
   *   <a href="#" data-reflex="ScheduledMealsReflex#example">Example</a>
   *
   * Arguments:
   *
   *   element - the element that triggered the reflex
   *             may be different than the Stimulus controller's this.element
   *
   *   reflex - the name of the reflex e.g. "ScheduledMealsReflex#example"
   *
   *   error - error message from the server
   */

  // beforeUpdate(element, reflex) {
  //  element.innerText = 'Updating...'
  // }


  // updateError(element, reflex, error) {
  //   console.error('updateError', error);
  //   element.innerText = 'Update Failed!'
  // }

  connect () {
    console.log("called connect on scheduled_meals_controller");
    StimulusReflex.register(this)
  }

  reflexSuccess(anchorElement, reflex, noop, reflexId) {
    console.log("ReflexSuccess schedule_meals controller hehehe");
  }
  reflexError(anchorElement, reflex, noop, reflexId) {
    console.log("ReflexError schedule_meals controller hehehe");
  }
  reflexHalted(anchorElement, reflex, noop, reflexId) {
    console.log("ReflexHalted schedule_meals controller hehehe");
  }

  afterRemoveScheduledMeal(anchorElement, reflex, noop, reflexId) {
    console.log("afterRSM schedule_meals controller hehehe");
  }

  remove(event, response) {
    event.preventDefault()
    console.log("called remove");
    if (event["detail"][0]) this.stimulate('ScheduledMealsReflex#remove', event.target)
  }

  push_out(event, response) {
    event.preventDefault()
    console.log("called push_out");
    if (event["detail"][0]) this.stimulate('ScheduledMealsReflex#push_out', event.target)
  }

  afterReflex(anchorElement, reflex, noop, reflexId) {
    console.log("after schedule_meals controller");
  }


  finalizeReflex(anchorElement, reflex, noop, reflexId) {
    console.log("finalize scheduled_meals_controller");
  }
}
