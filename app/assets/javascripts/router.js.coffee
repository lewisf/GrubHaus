define ["backbone"
        "views/recipe"], (Backbone, RecipeView) ->
  Router = Backbone.Router.extend
    routes: 
      "": "index"
    index: ->
    initialize: -> 
      @recipeView = new RecipeView()
      $("body").append @recipeView.el

    start: ->
      Backbone.history.start
        pushState: true

  initialize = ->
    router = new Router()
    router.start()

  {initialize: initialize}
