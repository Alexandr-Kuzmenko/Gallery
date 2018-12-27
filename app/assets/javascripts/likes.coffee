$(document).on 'turbolinks:load', ->
  $(document).ready ->
    $('#like').click ->
      switch $('#like').text()
        when 'Like'
          $('#like').html 'Unlike'
          $('#like').toggleClass('btn-secondary btn-success')
        when 'Unlike'
          $('#like').html 'Like'
          $('#like').toggleClass('btn-secondary btn-success')
    #  $('lcount').load(location.href+' lcount'))
