
define ["backbone"
        "views/recipe"
        "views/recipeList"
        "views/search"
        "views/createRecipe"],
  (Backbone, RecipeView, RecipeListView, IndexView, CreateRecipeView) ->
    Router = Backbone.Router.extend
      routes:
        "": "index"
        "recipes/search/:q": "index"
        "recipes": "showRecipes"
        "recipes/create": "createRecipe"
        "recipes/:id": "showRecipe"

      start: ->
        Backbone.history.start
          pushState: true

      index: (q)->
        if q?
          indexView = new IndexView q
        else
          indexView = new IndexView()
        $("section.container").html indexView.el

      showRecipe: (id) ->
        recipeView = new RecipeView {id: id}
        $("section.container").html recipeView.el

      showRecipes: ->
        recipeListView = new RecipeListView()
        $("section.container").html recipeListView.el

      createRecipe: ->
        createRecipeView = new CreateRecipeView()
        $("section.container").html createRecipeView.el

        # rendering here to avoid issue of model not being finished
        # look into this problem later.
        createRecipeView.render()


    initialize = ->
      window.router = new Router()
      window.router.start()

    {initialize: initialize}
