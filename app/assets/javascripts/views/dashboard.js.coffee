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
        @favorites = new RecipesCollection({ url: "/api/recipes/favorites.json" })
        @published = new RecipesCollection({ url: "/api/recipes/published.json" })
        @unpublished = new RecipesCollection({ url: "/api/recipes/unpublished.json" })
        @dashHtml = Handlebars.compile dashboardTemplate
        @recipeListHtml = Handlebars.compile recipeListTemplate

        @render()

        favorites = @favorites.fetch
          success: =>
            console.log "Favorites"
            @renderFavorites()

        published = @published.fetch
          success: =>
            console.log "Published"
            @renderPublished()

        unpublished = @unpublished.fetch
          success: =>
            console.log "Unpublished"
            @renderUnpublished()
      
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
