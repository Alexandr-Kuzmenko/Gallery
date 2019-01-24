$(document).on 'turbolinks:load', ->
  $(document).ready ->
    $('.carousel').find('.carousel-item').first().addClass('active')
    $('.carousel').carousel({
        interval: 10000
      })

$(document).on 'turbolinks:load', ->
  $(document).ready ->
    $('#nav_bar_open').click ->
      $('#nav_aside').width('15%');
      $('#nav_aside').css
        'min-width': '180px';
    return
$(document).on 'turbolinks:load', ->
  $(document).ready ->
    $('#nav_bar_close').click ->
      $('#nav_aside').width('0%');
      $('#nav_aside').css
        'min-width': '0px';
    return

# resizeTimer = undefined
# $(document).ready ->
#   $(window).resize ->
#     clearTimeout resizeTimer
#     resizeTimer = setTimeout((->
#       if innerWidth >= 1280
#         $('#carouselBgWp').carousel({
#           interval: 400
#         })
#         alert 'start'
#       else
#         $('#carouselBgWp').carousel('pause')
#         alert 'stop'
#       return
#     ), 500)
#     return
#   return