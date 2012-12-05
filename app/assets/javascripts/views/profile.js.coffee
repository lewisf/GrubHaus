define ["backbone"
        "handlebars"
        "models/user_profile",
        "collections/recipes",
        "views/profile_info",
        "text!templates/recipeList.html"
        "text!templates/profile.html"
        "jquery.simplemodal"],
  (Backbone, Handlebars, UserProfile, RecipesCollection, ProfileInfoView, recipeListHtml, profileHtml) ->

    class ProfileView extends Backbone.View
      
      initialize: (params) ->
        @template = Handlebars.compile profileHtml
        @recipeListHtml = Handlebars.compile recipeListHtml
        @favoritesUrl = "/api/recipes/favorites"
        @publishedUrl = "/api/recipes/published"
        if params? && params.id?
          @model = new UserProfile {_id: params.id}
          @favoritesUrl += "/#{params.id}"
          @publishedUrl += "/#{params.id}"
        else
          @model = new UserProfile

        @favorites =  new RecipesCollection { url: @favoritesUrl }
        @published = new RecipesCollection { url: @publishedUrl }
        @model.fetch
          success: =>
            @render()
          error: (data) =>
            console.log "Error"

      render: ->

        @$el.html @template @model.toJSON()
        profileInfoView = new ProfileInfoView { model: @model }
        $("#pinfo").html profileInfoView.el

        @favorites.fetch
          success: =>
            @renderFavoritedRecipes()
        @published.fetch
          success: =>
            @renderPublishedRecipes()

      renderPublishedRecipes: ->
        $("#profile-published-container").html @recipeListHtml
          recipes: @published.for_template()
          listId: "published-recipes"

      renderFavoritedRecipes: ->
        $("#profile-favorited-container").html @recipeListHtml
          recipes: @favorites.for_template()
          listId: "favorited-recipes"
