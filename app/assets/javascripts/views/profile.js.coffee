define ["backbone"
        "handlebars"
        "models/user_profile",
        "collections/recipes",
        "text!templates/recipeList.html"
        "text!templates/profile.html"],
  (Backbone, Handlebars, UserProfile, RecipesCollection, recipeListHtml, profileHtml) ->

    class ProfileView extends Backbone.View
      
      initialize: (params) ->
        @template = Handlebars.compile profileHtml
        @recipeListHtml = Handlebars.compile recipeListHtml
        @favoritesUrl = "/api/recipes/favorites"
        @publishedUrl = "/api/recipes/published"
        if params? && params.id?
          @model = new UserProfile {_id: params.id}
          favoritesUrl += "/#{params.id}"
          publishedUrl += "/#{params.id}"
        else
          @model = new UserProfile

        @favorites =  new RecipesCollection { url: @favoritesUrl }
        @published = new RecipesCollection { url: @publishedUrl }
        @model.fetch
          success: =>
            @render()
            @favorites.fetch
              success: =>
                @renderFavoritedRecipes()
            @published.fetch
              success: =>
                @renderPublishedRecipes()
                

      render: ->
        @$el.html @template @model.toJSON()

      renderPublishedRecipes: ->
        $("#profile-published-container").html @recipeListHtml
          recipes: @published.for_template()
          listId: "published-recipes"

      renderFavoritedRecipes: ->
        $("#profile-favorited-container").html @recipeListHtml
          recipes: @favorites.for_template()
          listId: "favorited-recipes"
