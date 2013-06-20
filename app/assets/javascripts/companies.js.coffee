# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  $(".company-description-form").hide()
  $("#company-description-edit-button").click ->
    $(".company-description-text").hide()
    $("#company-description-edit-button").hide()
    $(".company-description-form").show()
  $("#company-description-cancel").click ->
    $(".company-description-text").show()
    $("#company-description-edit-button").show()
    $(".company-description-form").hide()