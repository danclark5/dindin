document.addEventListener("turbolinks:load", function() {
  const shopping_item_carets = document.querySelectorAll('.shopping-item-caret');
  if (shopping_item_carets.length > 0) {
    shopping_item_carets.forEach(function(shopping_item) {
      shopping_item.addEventListener("click", function(e) {
        e.currentTarget.classList.toggle('is-active');
        let target = document.getElementById(e.currentTarget.dataset.target);
        target.classList.toggle('is-hidden');
      });
    });
  }

  const snooze_buttons = document.querySelectorAll('.snooze_button');
  if (snooze_buttons.length > 0) {
    snooze_buttons.forEach(function(snooze_button) {
      snooze_button.addEventListener("click", function(e) {
        e.currentTarget.closest(".shopping_item_container").classList.remove("is-hidden");
      });
    });
    const reset_snoozes_button = document.querySelector("#reset_snoozes_button");
    reset_snoozes_button.addEventListener("click", function(e) {
      const shopping_item_containers = document.querySelectorAll(".shopping_item_container");
      shopping_item_containers.forEach(function(shopping_item_containers) {
        shopping_item_containers.classList.remove("is-hidden");
      })
    })
  }
});
