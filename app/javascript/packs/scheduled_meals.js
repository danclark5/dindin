document.addEventListener("turbolinks:load", function() {
  require("jquery-ui");

  if (document.getElementById("ingredient")) {
    $('#ingredient').autocomplete({
      source: $('#ingredient').data('autocomplete-source'),
      select: function(_, ui) {
        $('#ingredient').val(ui.item.label);
        document.getElementById('add-ingredient-button').setAttribute('data-ingredient_id', ui.item.value);
        document.getElementById('add-ingredient-button').setAttribute('data-ingredient_term', ui.item.label);
        return false;
      },
      search: function(_, ui) {
        document.getElementById('add-ingredient-button').setAttribute('data-ingredient_id', "");
        document.getElementById('add-ingredient-button').setAttribute('data-ingredient_term', "");
      },
      response: function(_, ui) {
        if (!ui.content.some(elem => elem.label === this.value)) {
          document.getElementById('add-ingredient-button').setAttribute('data-ingredient_id', 0);
          document.getElementById('add-ingredient-button').setAttribute('data-ingredient_term', this.value);
          ui["content"].unshift({value: 0, label: this.value})
        }
      },
      minLength: 0
    }).autocomplete("instance")._renderMenu = function( ul, items ) {
      //this._renderItemData( ul, {value: 0, label: this.element[0].value} )
      let that = this;
      $.each( items, function( index, item ) {
        that._renderItemData( ul, item );
      });
      $( ul ).find( "li:odd" ).addClass( "odd" );
    };

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
