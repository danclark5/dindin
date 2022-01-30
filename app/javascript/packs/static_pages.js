function deselect_card(card) {
  delete card.dataset.selected;
  card.classList.remove("has-background-info");
  card.classList.add("has-background-success-light");
  const already_selected = Array.from(document.querySelectorAll("[data-selected]"));
  const message = document.getElementById("meal_swap_message");
  const message_body_initial = document.getElementById("meal_swap_message_body_initial");
  const message_body_ready = document.getElementById("meal_swap_message_body_ready");
  const meal_swap_button = document.getElementById("meal_swap_button");
  if (already_selected.length > 0) {
    already_selected[0].dataset.selected = 1;
    meal_swap_button.dataset.first_meal = already_selected[0].dataset.scheduled_meal_id;
    message_body_initial.classList.remove('is-hidden');
    message_body_ready.classList.add('is-hidden');
  } else {
    message.classList.add("is-hidden");
    message_body_initial.classList.add('is-hidden');
    message_body_ready.classList.add('is-hidden');
  }
}

function select_card(card) {
  const already_selected = Array.from(document.querySelectorAll("[data-selected]"));
  const message_body_initial = document.getElementById("meal_swap_message_body_initial");
  const message_body_ready = document.getElementById("meal_swap_message_body_ready");
  if (already_selected.length > 1) {
    already_selected.sort((a, b) => {
      return a.dataset.selected - b.dataset.selected;
    });
    deselect_card(already_selected[0]);
    card.dataset.selected = 2;
    meal_swap_button.dataset.second_meal = card.dataset.scheduled_meal_id;
    message_body_initial.classList.add('is-hidden');
    message_body_ready.classList.remove('is-hidden');
  } else if (already_selected.length == 1) {
    card.dataset.selected = already_selected.length + 1;
    meal_swap_button.dataset.second_meal = card.dataset.scheduled_meal_id;
    message_body_initial.classList.add('is-hidden');
    message_body_ready.classList.remove('is-hidden');
  } else {
    card.dataset.selected = already_selected.length + 1;
    meal_swap_button.dataset.first_meal = card.dataset.scheduled_meal_id;
    message_body_initial.classList.remove('is-hidden');
  }
  card.classList.remove("has-background-success-light");
  card.classList.add("has-background-info");
  const message = document.getElementById("meal_swap_message");
  message.classList.remove("is-hidden");
}


function toggle_card(event) {
  const card = event.currentTarget.firstElementChild;
  const is_selected = card.hasAttribute("data-selected");
  if(is_selected) {
    deselect_card(card);
  } else {
    select_card(card);
  }
}

document.addEventListener("turbolinks:load", function() {
  const navbar_burgers = document.querySelectorAll('.navbar-burger');
  if (navbar_burgers.length > 0) {
    navbar_burgers.forEach(function(navbar_burger) {
      navbar_burger.addEventListener("click",  function(e) {
        e.target.classList.toggle('is-active');
        let target = document.getElementById(e.target.dataset.target);
        target.classList.toggle('is-active');
      })
    })
  }

  const scheduled_meal_cards = document.getElementsByClassName("scheduled_meal_card");
  for (const card of scheduled_meal_cards) {
    card.addEventListener("click", toggle_card);
  }
})
