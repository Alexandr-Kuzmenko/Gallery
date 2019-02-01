$(document).on 'turbolinks:load', ->
  $(document).ready ->
    $('.carousel').find('.carousel-item').first().addClass('active')
    $('.carousel').carousel({
        interval: 10000
      })
    setTimeout (->
      $('.alert').detach()
      return
    ), 4000

# left menu options
overlayTimer = undefined
$(document).on 'turbolinks:load', ->
  $(document).ready ->
    $('#menu-overlay-btn').click ->
      $('.page_content').fadeTo 500, 0.5
      $('.page_content').css
        'z-index': '-2'
      clearTimeout overlayTimer
      overlayTimer = setTimeout((->
        switch $('#menu-overlay-btn').html()
          when '\n<i class="fa fa-navicon"></i>\n'
            $('#menu-overlay-btn').html '\n<i class="fa fa-chevron-left"></i>\n'
            $('.left-overlay').width 180
            setTimeout (->
              $('.left-overlay .overlay').css
                'display': 'block';
              return
            ), 500

            $('#log-overlay-btn').html '\n<i class="fa fa-key"></i>\n'
            $('.right-overlay .overlay').css
              'display': 'none';
            $('.right-overlay').width 0

            $('#mid-overlay-btn').html '\n<i class="fa fa-chevron-down"></i>\n'
            $('.mid-overlay .overlay').css
              'display': 'none';
            $('.mid-overlay').height 0
          when '\n<i class="fa fa-chevron-left"></i>\n'
            $('#menu-overlay-btn').html '\n<i class="fa fa-navicon"></i>\n'
            $('.left-overlay .overlay').css
              'display': 'none';
            $('.left-overlay').width 0

            $('.page_content').fadeTo 500, 1
            setTimeout (->
              $('.page_content').css
                'z-index': 'auto'
              return
            ), 500
      ), 300)
      return
    return

# right menu options
overlayTimer = undefined
$(document).on 'turbolinks:load', ->
  $(document).ready ->
    $('#log-overlay-btn').click ->
      $('.page_content').fadeTo 500, .5
      $('.page_content').css
        'z-index': '-2'
      clearTimeout overlayTimer
      overlayTimer = setTimeout((->
        switch $('#log-overlay-btn').html()
          when '\n<i class="fa fa-key"></i>\n'
            $('#log-overlay-btn').html '\n<i class="fa fa-chevron-right"></i>\n'
            $('.right-overlay').width 180
            setTimeout (->
              $('.right-overlay .overlay').css
                'display': 'block';
              return
            ), 500

            $('#menu-overlay-btn').html '\n<i class="fa fa-navicon"></i>\n'
            $('.left-overlay .overlay').css
              'display': 'none';
            $('.left-overlay').width 0

            $('#mid-overlay-btn').html '\n<i class="fa fa-chevron-down"></i>\n'
            $('.mid-overlay .overlay').css
              'display': 'none';
            $('.mid-overlay').height 0
          when '\n<i class="fa fa-chevron-right"></i>\n'
            $('#log-overlay-btn').html '\n<i class="fa fa-key"></i>\n'
            $('.right-overlay .overlay').css
              'display': 'none';
            $('.right-overlay').width 0

            $('.page_content').fadeTo 500, 1
            setTimeout (->
              $('.page_content').css
                'z-index': 'auto'
              return
            ), 500
      ), 300)
      return
    return

# mid menu options
overlayTimer = undefined
$(document).on 'turbolinks:load', ->
  $(document).ready ->
    $('#mid-overlay-btn').click ->
      $('.page_content').fadeTo 500, .5
      $('.page_content').css
        'z-index': '-2'
      clearTimeout overlayTimer
      overlayTimer = setTimeout((->
        switch $('#mid-overlay-btn').html()
          when '\n<i class="fa fa-chevron-down"></i>\n'
            $('#mid-overlay-btn').html '\n<i class="fa fa-chevron-up"></i>\n'
            $('.mid-overlay').height $(window).height()
            setTimeout (->
              $('.mid-overlay .overlay').css
                'display': 'block';
              return
            ), 500

            $('#menu-overlay-btn').html '\n<i class="fa fa-navicon"></i>\n'
            $('.left-overlay .overlay').css
              'display': 'none';
            $('.left-overlay').width 0

            $('#log-overlay-btn').html '\n<i class="fa fa-key"></i>\n'
            $('.right-overlay .overlay').css
              'display': 'none';
            $('.right-overlay').width 0
          when '\n<i class="fa fa-chevron-up"></i>\n'
            $('#mid-overlay-btn').html '\n<i class="fa fa-chevron-down"></i>\n'
            $('.mid-overlay .overlay').css
              'display': 'none';
            $('.mid-overlay').height 0

            $('.page_content').fadeTo 500, 1
            setTimeout (->
              $('.page_content').css
                'z-index': 'auto'
              return
            ), 500
      ), 300)
      return
    return

#resizeTimer = undefined
#$(document).ready ->
#  $(window).resize ->
#    clearTimeout resizeTimer
#    resizeTimer = setTimeout((->
#      if innerWidth >= 1280
#        $('#carouselBgWp').carousel({
#          interval: 400
#        })
#        alert 'start'
#      else
#        $('#carouselBgWp').carousel('pause')
#        alert 'stop'
#      return
#    ), 500)
#    return
#  return
