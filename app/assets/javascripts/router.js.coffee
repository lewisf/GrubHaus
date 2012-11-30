
define ["backbone"
        "views/recipe"
        "views/dashboard"
        "views/search"
        "views/createRecipe"],
  (Backbone, RecipeView, DashboardView, IndexView, CreateRecipeView) ->
    Router = Backbone.Router.extend
      routes:
        "": "index"
        "recipes/search/:q": "index"
        "recipes": "showDashboard"
        "recipes/create": "createRecipe"
        "recipes/edit/:id": "editRecipe"
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

      showDashboard: ->
        dashboardView = new DashboardView()
        $("section.container").html dashboardView.el

      createRecipe: ->
        createRecipeView = new CreateRecipeView()
        $("section.container").html createRecipeView.el

        # rendering here to avoid issue of model not being finished
        # look into this problem later.
        createRecipeView.render()

      editRecipe: (id) ->
        editRecipeView = new CreateRecipeView {id: id}
        $("section.container").html editRecipeView.el


    initialize = ->
      window.router = new Router()
      window.router.start()

    {initialize: initialize}
