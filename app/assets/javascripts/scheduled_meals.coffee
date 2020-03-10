# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

build_meal_result = (meal) ->
  if meal.tag
    tag = "<span class=\"tag is-primary is-pulled-right\">" + meal.tag + "</span>"
  else
    tag = ""
  "<div class=\"meal_results\">" + meal.label + tag  + "</div>"

$ ->
  $('#meal').autocomplete(
    source: $('#meal').data('autocomplete-source')
    select: (_, ui) =>
      $('#scheduled_meal_meal_id').val(ui.item.value)
      $('#meal').val(ui.item.label)
      return false
    minLength: 0
    ).autocomplete("instance")._renderItem = ((ul,meal) ->
      return $( "<li>" )
        .append( build_meal_result(meal) )
        .appendTo( ul )
    )
  $('#meal').focus ->
    $(this).autocomplete("search",$(this).val())
