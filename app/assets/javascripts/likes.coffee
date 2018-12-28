$(document).on 'turbolinks:load', ->
  $(document).ready ->
    $('#like').click ->
      switch $('#like').text()
        when 'Like'
          $('#like').html 'Unlike'
          $('#like').toggleClass('btn-secondary btn-success')
          like_counter = +$('lcount').text() + 1
          $('lcount').html like_counter
          return
        when 'Unlike'
          $('#like').html 'Like'
          $('#like').toggleClass('btn-secondary btn-success')
          like_counter = +$('lcount').text() - 1
          $('lcount').html like_counter
          return
