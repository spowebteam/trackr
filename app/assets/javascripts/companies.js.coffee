# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  $(".company-description-form").hide()
  $('#log-entry-form').hide()
  $("#company-description-edit-button").click ->
    $(".company-description-text").hide()
    $("#company-description-edit-button").hide()
    $(".company-description-form").show()
  $("#company-description-cancel").click ->
    $(".company-description-text").show()
    $("#company-description-edit-button").show()
    $(".company-description-form").hide()
  $('#log-entry-button').click ->
  	$('#log-entry-button').hide()
  	$('#log-entry-form').show()
  $('#log-entry-cancel').click ->
  	$('#log-entry-button').show()
  	$('#log-entry-form').hide()

jQuery ->
  $('#company-table').dataTable
    sPaginationType: "full_numbers"
    bJQueryUI: true
    aoColumns: [
      null,
      null,
      null,
      null,
      null,
      bSearchable: false,
      null,
        bSearchable: false ]
