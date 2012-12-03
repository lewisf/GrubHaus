define ["backbone"
        "handlebars"
        "models/user_profile",
        "collections/recipes",
        "text!templates/recipeList.html"
        "text!templates/profile.html"
        "jquery.simplemodal"],
  (Backbone, Handlebars, UserProfile, RecipesCollection, recipeListHtml, profileHtml) ->

    class ProfileView extends Backbone.View
      
      events:
        'dblclick #name.profile-editable': 'editName',
        'dblclick #username.profile-editable': 'editUsername',
        'dblclick #tagline.profile-editable': 'editTagline'

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
            console.log @model
            @render()
            @favorites.fetch
              success: =>
                @renderFavoritedRecipes()
            @published.fetch
              success: =>
                @renderPublishedRecipes()
          error: (data) =>
            console.log "Error"
                

      render: ->
        @$el.html @template @model.toJSON()
        if @model.get("editable_by_user") is true
          @makeEditable()

      renderPublishedRecipes: ->
        $("#profile-published-container").html @recipeListHtml
          recipes: @published.for_template()
          listId: "published-recipes"

      renderFavoritedRecipes: ->
        $("#profile-favorited-container").html @recipeListHtml
          recipes: @favorites.for_template()
          listId: "favorited-recipes"

      makeEditable: ->
        $("#name, #username, #tagline").addClass "profile-editable"

      editName: ->
        e.preventDefalt()
        html = "<form id='edit-profile-name-form'>"
        html += "<input type='text' name='first_name' value='#{@model.get("profile").first_name}' size=60/>
               <br /><br />
               <input type='text' name='last_name' value='#{@model.get('profile').last_name}' size=60 />
               <br /><br />
               <input type='submit' class='submit-button'>"
        html += "</form>"
        

      editUsername: ->

      editTagline: ->
