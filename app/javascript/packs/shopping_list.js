function toggle_carret(event) {
  event.currentTarget.classList.toggle('is-active');
  let target = document.getElementById(event.currentTarget.dataset.target);
  target.classList.toggle('is-hidden');
}

function toggle_snooze_button(event){
  event.currentTarget.closest(".shopping_item_container").classList.remove("is-hidden");
}

function unsnooze_all(event){
  const shopping_item_containers = document.querySelectorAll(".shopping_item_container");
  shopping_item_containers.forEach(function(shopping_item_container) {
    shopping_item_container.classList.remove("is-hidden");
    shopping_item_container.classList.remove("snoozed");
  });
}

function toggle_show_snoozed(event){
  const snoozed_shopping_item_containers = document.querySelectorAll(".snoozed");
  snoozed_shopping_item_containers.forEach(function(shopping_item_container) {
    shopping_item_container.classList.toggle("is-hidden");
  });
  toggle_snoozes_button = document.querySelector("#toggle_snoozes_button")
  if (toggle_snoozes_button.innerHTML == "Show Snoozed") {
    toggle_snoozes_button.innerHTML = "Hide Snoozed";
  } else {
    toggle_snoozes_button.innerHTML = "Show Snoozed";
  }
}

function link_event_listeners(event) {
  const shopping_item_carets = document.querySelectorAll('.shopping-item-caret');
  if (shopping_item_carets.length > 0) {
    shopping_item_carets.forEach(function(shopping_item) {
      shopping_item.addEventListener("click", toggle_carret);
    });
  }

  const snooze_buttons = document.querySelectorAll('.snooze_button');
  if (snooze_buttons.length > 0) {
    snooze_buttons.forEach(function(snooze_button) {
      snooze_button.addEventListener("click",  toggle_snooze_button);
    });
    const reset_snoozes_button = document.querySelector("#reset_snoozes_button");
    reset_snoozes_button.addEventListener("click", unsnooze_all);
  }

  const toggle_snoozes_buttons = document.querySelectorAll('#toggle_snoozes_button');
  if (toggle_snoozes_buttons.length > 0) {
    toggle_snoozes_buttons.forEach(function(toggle_snoozes_button) {
      toggle_snoozes_button.addEventListener("click", toggle_show_snoozed);
    });
  }
}

document.addEventListener("turbolinks:load", link_event_listeners);

document.addEventListener('stimulus-reflex:after', event => {
  list = ['ShoppingListItemComponent', 'ShoppingListHeaderComponent', 'ShoppingListDetailsComponent'];
  if (list.includes(event.detail.reflex.split("#")[0])){
    link_event_listeners(event)
  }
})
