# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

toggle_burger = ->
  target = document.getElementById(this.dataset.target)
  this.classList.toggle('is-active')
  target.classList.toggle('is-active')

load = ->
  navbar_burgers = document.querySelectorAll('.navbar-burger')
  if navbar_burgers.length > 0
    for navbar_burger in navbar_burgers
      navbar_burger.addEventListener('click', toggle_burger)

document.addEventListener('DOMContentLoaded', load)
