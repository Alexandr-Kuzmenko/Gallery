# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'turbolinks:load', ->
  $(document).ready ->
    $('#follow').click ->
      switch $('#follow').html()
        when '<i class="fa fa-bell"></i>'
          $('#follow').html '<i class="fa fa-bell-o"></i>'
          $('#follow').toggleClass('btn-info btn-danger')
        when '<i class="fa fa-bell-o"></i>'
          $('#follow').html '<i class="fa fa-bell"></i>'
          $('#follow').toggleClass('btn-info btn-danger')
      return

    $('.carousel').find('.carousel-item').first().addClass('active')
    $('.carousel').carousel({
        interval: 5000
      })
