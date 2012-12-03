define ["jquery"],
  ($) ->

    notice: (msg) =>
      el = $("p.notice").first()
      $(el).html msg
      clearTimeout window.ntimeout
      $(el).slideDown 'fast', ->
        window.ntimeout = setTimeout ->
          $(el).slideUp('fast')
        , 1000

    alert: (msg) =>
      el = $("p.alert").first()
      $(el).html msg
      clearTimeout window.atimeout
      $(el).slideDown 'fast', ->
        window.atimeout = setTimeout ->
          $(el).slideUp('fast')
        , 1000

    success: (msg) =>
      el = $("p.success").first()
      $(el).html msg
      clearTimeout window.stimeout
      $(el).slideDown 'fast', ->
        window.stimeout = setTimeout ->
          $(el).slideUp('fast')
        , 1000

    error: (msg) =>
      el = $("p.error").first()
      $(el).html msg
      clearTimeout window.etimeout
      $(el).slideDown 'fast', ->
        window.etimeout = setTimeout ->
          $(el).slideUp 'fast'
        , 1000

    info: (msg) =>
      el = $("p.info").first()
      clearTimeout window.itimeout
      el.html msg
      $(el).slideDown 'fast', ->
        window.itimeout = setTimeout ->
          $(el).slideUp 'fast'
        , 1000
