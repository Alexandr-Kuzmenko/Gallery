# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  $('#follow').click ->
    switch $('#follow').text()
      when 'Follow'
        $('#follow').html 'Unfollow'
        $('#follow').toggleClass('btn-info btn-danger')
      when 'Unfollow'
        $('#follow').html 'Follow'
        $('#follow').toggleClass('btn-info btn-danger')
    return
