require ["app", "router"], (app, Router) ->
  app.router = new Router()

  Backbone.history.start
    pushState: true
    root: app.root

  $(document).on "click", "a:not([data-bypass])", (e) ->
    href = 
      prop: $(@).prop "href"
      attr: $(@).attr "href"

    root = "#{location.protocol}//#{location.host}#{app.root}"

    if href.prop and href.prop[0...] is root
      e.preventDefault()
      Backbone.history.navigate href.attr, true