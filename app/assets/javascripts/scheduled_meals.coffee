# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
select_meal = (event, ui) ->
  $('#scheduled_meal_meal_id').val(ui.item.value)
  $('#meal').val(ui.item.label)
  return false

$ ->
  $('#meal').autocomplete
    source: $('#meal').data('autocomplete-source')
    select: select_meal
 
