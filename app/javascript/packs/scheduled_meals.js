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
      response: function(_, ui) {
        if (ui["content"].length == 0) {
          document.getElementById('create-ingredient').classList.remove("is-hidden")
          console.log("Ingredient not found!")
          const ingredient_label = document.getElementById('ingredient').value
          document.getElementById('create-ingredient-link').setAttribute('data-ingredient_term', ingredient_label);
        } else {
          document.getElementById('create-ingredient').classList.add("is-hidden")
        }
      },
      minLength: 0
    });

    $('#ingredient').focus( function() {
      if (!$(this).val()) {
        $(this).autocomplete("search",$(this).val())
      }
    });
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

    $('#meal').focus( function() {
      if (!$(this).val()) {
        $(this).autocomplete("search",$(this).val())
      }
    });
  }
});
