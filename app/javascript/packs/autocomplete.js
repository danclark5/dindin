function autocomplete_ingredients() {
  $('#ingredient').autocomplete({
    source: $('#ingredient').data('autocomplete-source'),
    select: function(_, ui) {
      $('#ingredient').val(ui.item.label);
      document.getElementById('add-ingredient-button').setAttribute('data-ingredient_id', ui.item.value);
      document.getElementById('add-ingredient-button').setAttribute('data-ingredient_term', ui.item.label);
      return false;
    },
    search: function(_, ui) {
      if (!this.value) {
        document.getElementById('add-ingredient-button').setAttribute('data-ingredient_id', "");
        document.getElementById('add-ingredient-button').setAttribute('data-ingredient_term', "");
      }
    },
    response: function(_, ui) {
      if (probable_item = ui.content.find(elem => elem.label.toLowerCase() === this.value.toLowerCase())) {
        document.getElementById('add-ingredient-button').setAttribute('data-ingredient_id', probable_item.value);
      } else {
        document.getElementById('add-ingredient-button').setAttribute('data-ingredient_id', 0);
        document.getElementById('add-ingredient-button').setAttribute('data-ingredient_term', this.value);
        ui["content"].unshift({value: 0, label: this.value})
      }
    },
    minLength: 0
  })

  $('#ingredient').focus( function() {
    if (!$(this).val()) {
      $(this).autocomplete("search",$(this).val())
    }
  });
}

function autocomplete_meals() {
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

function link_event_listeners(event) {
  require("jquery-ui");
  if (document.getElementById("ingredient")) {
    autocomplete_ingredients();
  }

  if (document.getElementById("meal")) {
    autocomplete_meals();
  }
}

document.addEventListener("turbolinks:load", link_event_listeners);

document.addEventListener('stimulus-reflex:finalize', event => {
  list = ['MealReflex', 'ShoppingList'];
  if (list.includes(event.detail.reflex.split("#")[0])){
    $("#ingredient").val("")
  }
})
