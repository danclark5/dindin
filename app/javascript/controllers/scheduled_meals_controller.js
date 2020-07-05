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

  remove_scheduled_meal(event, response) {
    event.preventDefault()
    if (event["detail"][0]) this.stimulate('ScheduledMealsReflex#remove_scheduled_meal', event.target)
  }
}
