function toggle_carret(event) {
  event.currentTarget.classList.toggle('is-active');
  let target = document.getElementById(event.currentTarget.dataset.target);
  target.classList.toggle('is-hidden');
}

function toggle_snooze_button(event){
  console.log(event)
  event.currentTarget.closest(".shopping_item_container").classList.remove("is-hidden");
}

function unsnooze_all(event){
  console.log(event)
  const shopping_item_containers = document.querySelectorAll(".shopping_item_container");
  shopping_item_containers.forEach(function(shopping_item_containers) {
    shopping_item_containers.classList.remove("is-hidden");
  })
}

function link_event_listeners(event) {
  const shopping_item_carets = document.querySelectorAll('.shopping-item-caret');
  if (shopping_item_carets.length > 0) {
    shopping_item_carets.forEach(function(shopping_item) {
      shopping_item.removeEventListener("click", toggle_carret);
      shopping_item.addEventListener("click", toggle_carret);
    });
  }

  const snooze_buttons = document.querySelectorAll('.snooze_button');
  if (snooze_buttons.length > 0) {
    snooze_buttons.forEach(function(snooze_button) {
      snooze_button.removeEventListener("click",  toggle_snooze_button)
      snooze_button.addEventListener("click",  toggle_snooze_button)
    });
    const reset_snoozes_button = document.querySelector("#reset_snoozes_button");
    reset_snoozes_button.removeEventListener("click", unsnooze_all)
    reset_snoozes_button.addEventListener("click", unsnooze_all)
  }
}

document.addEventListener("turbolinks:load", link_event_listeners);

document.addEventListener('stimulus-reflex:after', event => {
  list = ['ShoppingListItemComponent', 'ShoppingListHeaderComponent'];
  console.log(event.detail.reflex.split("#")[0]);
  if (list.includes(event.detail.reflex.split("#")[0])){
    console.log("linked")
    link_event_listeners(event)
  }
})
