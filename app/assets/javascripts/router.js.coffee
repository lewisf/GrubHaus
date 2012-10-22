define ["app"], (app) ->
  Router = Backbone.Router.extend
    routes: 
      "": "index"
    index: ->
  return Router
