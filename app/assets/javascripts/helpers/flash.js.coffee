define ["jquery"],
  ($) ->
    notice: (msg) =>
      el = $("p.notice").first()
      $(el).html msg
      $(el).slideDown 'fast', ->
        setTimeout( -> $(el).slideUp 'fast', 2000)

    alert: (msg) =>
      el = $("p.alert").first()
      $(el).html msg
      $(el).slideDown 'fast', ->
        $(el).slideUp 'fast'

    success: (msg) =>
      el = $("p.success").first()
      $(el).html msg
      $(el).slideDown 'fast', ->
        setTimeout (->
          $(el).slideUp('fast')
        ), 1000

    error: (msg) =>
      el = $("p.error").first()
      $(el).html msg
      $(el).slideDown 'fast', ->
        $(el).slideUp 'fast'

    info: (msg) =>
      el = $("p.info").first()
      el.html msg
      $(el).slideDown 'fast', ->
        $(el).slideUp 'fast'
