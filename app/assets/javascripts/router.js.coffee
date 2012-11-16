
define ["backbone"
        "views/recipe"
        "views/recipeList"
        "views/index"
        "views/createRecipe"], 
  (Backbone, RecipeView, RecipeListView, IndexView, CreateRecipeView) ->
    Router = Backbone.Router.extend
      routes: 
        "": "showRecipes"
        "recipes": "showRecipes"
        "recipes/create": "createRecipe"
        "recipes/:id": "showRecipe"

      start: ->
        Backbone.history.start
          pushState: true

      # index: ->
      #   indexView = new IndexView()

      showRecipe: (id) ->
        recipeView = new RecipeView {id: id}
        $("section.container").html recipeView.el

      showRecipes: ->
        recipeListView = new RecipeListView()
        $("section.container").html recipeListView.el

      createRecipe: ->
        createRecipeView = new CreateRecipeView()
        $("section.container").html createRecipeView.el


    initialize = ->
      router = new Router()
      router.start()

    {initialize: initialize}
