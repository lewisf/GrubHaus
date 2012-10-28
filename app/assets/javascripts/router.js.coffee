
define ["backbone"
        "views/recipe"
        "views/recipeList"
        "views/index"], 
  (Backbone, RecipeView, RecipeListView, IndexView) ->
    Router = Backbone.Router.extend
      routes: 
        "": "index"
        "recipes": "showRecipes"
        "recipes/:id": "showRecipe"

      start: ->
        Backbone.history.start
          pushState: true

      index: ->
        indexView = new IndexView()
        $("nav").html indexView.el

      showRecipe: (id) ->
        recipeView = new RecipeView {id: id}
        $("section.container").html recipeView.el

      showRecipes: ->
        recipeListView = new RecipeListView()
        $("section.container").html recipeListView.el


    initialize = ->
      router = new Router()
      router.start()

    {initialize: initialize}
