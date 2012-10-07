require ['jquery', 'backbone', 'GrubHaus'], ($, Backbone, GrubHaus) ->

  $ ->
    window.GrubHaus = new GrubHaus()
    Backbone.history.start
      pushState: true
    window.GrubHaus.start()
