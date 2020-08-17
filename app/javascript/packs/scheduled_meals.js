document.addEventListener("turbolinks:load", function() {
  require("jquery-ui");

  if (document.getElementById("ingredient")) {
    $('#ingredient').autocomplete({
      source: $('#ingredient').data('autocomplete-source'),
      select: function(_, ui) {
        $('#ingredient').val(ui.item.label);
        document.getElementById('add-ingredient-button').setAttribute('data-ingredient_id', ui.item.value);
        return false;
      },
      minLength: 0
    });

    $('#ingredient').focus( function() {
      if (!$(this).val()) {
        $(this).autocomplete("search",$(this).val())
      }
    });
  }

  function build_meal_result(meal) {
    if (meal.tag) {
      tag = "<span class=\"tag is-primary is-pulled-right\">" + meal.tag + "</span>";
    } else {
      tag = "";
    }
    return "<div class=\"meal_results\">" + meal.label + tag  + "</div>";
  }

  if (document.getElementById("meal")) {
    $('#meal').autocomplete({
      source: $('#meal').data('autocomplete-source'),
      select: function(_, ui) {
        $('#scheduled_meal_meal_id').val(ui.item.value);
        $('#meal').val(ui.item.label);
        return false;
      },
      minLength: 0
    })
      .autocomplete("instance")._renderItem = function(ul,meal) {
        return $( "<li>" )
          .append( build_meal_result(meal) )
          .appendTo( ul );
      };

    $('#meal').focus( function() {
      if (!$(this).val()) {
        $(this).autocomplete("search",$(this).val())
      }
    });
  }
});
