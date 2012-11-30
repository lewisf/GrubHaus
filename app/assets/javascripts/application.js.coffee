define ["jquery", 
        "jquery.simplemodal",
        "lodash", 
        "backbone",
        "handlebars",
        "router"],
  ($, simplemodal, _, Backbone, Handlebars, Router) ->

    initialize = ->
      setModalDefaults()
      Backbone.emulateHTTP = true

      Router.initialize()

    setModalDefaults = ->
      $.modal.defaults.closeClass = "modalClose"
      $.modal.defaults.overlayClose = true

    return {initialize: initialize, root: "/"}



