define ["jquery", 
        "lodash", 
        "backbone",
        "handlebars",
        "router"],
  ($, _, Backbone, Handlebars, Router) ->

    initialize = ->
      Router.initialize()

    return {initialize: initialize, root: "/"}



