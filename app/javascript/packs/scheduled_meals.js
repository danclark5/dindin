document.addEventListener("turbolinks:load", function() {
  require("jquery-ui");

  function build_meal_result(meal) {
    if (meal.tag) {
      tag = "<span class=\"tag is-primary is-pulled-right\">" + meal.tag + "</span>";
    } else {
      tag = "";
    }
    return "<div class=\"meal_results\">" + meal.label + tag  + "</div>";
  }
  $('#meal').autocomplete({
    source: $('#meal').data('autocomplete-source'),
    select: function(_, ui) {
      $('#scheduled_meal_meal_id').val(ui.item.value)
      $('#meal').val(ui.item.label)
      return false
    },
    minLength: 0
  });
  $('#meal').focus( function() {
    $(this).autocomplete("search",$(this).val())
  }).autocomplete("instance")._renderItem = function(ul,meal) {
    return $( "<li>" )
      .append( build_meal_result(meal) )
      .appendTo( ul );
  }
});
