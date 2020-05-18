document.addEventListener("turbolinks:load", function() {
  const navbar_burgers = document.querySelectorAll('.navbar-burger')
  if (navbar_burgers.length > 0) {
    navbar_burgers.forEach(function(navbar_burger) {
      navbar_burger.addEventListener("click",  function(e) {
        e.target.classList.toggle('is-active')
        let target = document.getElementById(e.target.dataset.target)
        target.classList.toggle('is-active')
      })
    })
  }
})
