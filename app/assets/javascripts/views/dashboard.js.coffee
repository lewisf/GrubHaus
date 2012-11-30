define ["jquery"
        "lodash"
        "backbone"
        "handlebars"
        "collections/recipes"
        "views/recipeList"
        "text!templates/recipeList.html"
        "text!templates/dashboard.html"],
  ($, _, Backbone, Handlebars, RecipesCollection, RecipeListView,
   recipeListTemplate, dashboardTemplate, ) ->
    Dashboard = Backbone.View.extend
      initialize: ->
        @favorites = new RecipesCollection { url: "/api/recipes/favorites.json" }
        @published = new RecipesCollection { url: "/api/recipes/published.json" }
        @unpublished = new RecipesCollection { url: "/api/recipes/unpublished.json" }
        @all = new RecipesCollection
        @dashHtml = Handlebars.compile dashboardTemplate
        @recipeListHtml = Handlebars.compile recipeListTemplate

        @render()

        favorites = @favorites.fetch
          success: =>
            @renderFavorites()

        published = @published.fetch
          success: =>
            @renderPublished()

        unpublished = @unpublished.fetch
          success: =>
            @renderUnpublished()

        all = @all.fetch
          success: =>
            @renderall()
      
      render: ->
        @$el.html @dashHtml
      
      renderFavorites: ->
        $("#favorites-container").html @recipeListHtml
          recipes: @favorites.for_template()

      renderPublished: ->
        $("#published-container").html @recipeListHtml
          recipes: @published.for_template()

      renderUnpublished: ->
        $("#unpublished-container").html @recipeListHtml
          recipes: @unpublished.for_template()
      
      renderall: ->
        $("#all-container").html @recipeListHtml
          recipes: @all.for_template()
