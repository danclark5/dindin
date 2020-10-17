document.addEventListener("turbolinks:load", function() {
  const shopping_item_carets = document.querySelectorAll('.shopping-item-caret')
  if (shopping_item_carets.length > 0) {
    shopping_item_carets.forEach(function(shopping_item) {
      shopping_item.addEventListener("click", function(e) {
        e.currentTarget.classList.toggle('is-active');
        let target = document.getElementById(e.currentTarget.dataset.target);
        target.classList.toggle('is-hidden');
      })
    })
  }
});
