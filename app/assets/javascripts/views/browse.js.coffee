define ["backbone"
        "handlebars"
        "collections/recipes"
        "views/recipeList"
        "text!templates/recipeList.html"
        "text!templates/browse.html"],
  (Backbone, Handlebars, RecipesCollection, RecipeListView,
   recipeListTemplate, browseTemplate) ->
    BrowseView = Backbone.View.extend
      initialize: ->
        @all = new RecipesCollection { url: "/api/recipes" }
        @browseHtml = Handlebars.compile browseTemplate
        @recipeListHtml = Handlebars.compile recipeListTemplate
        @render()
        all = @all.fetch
          success: =>
            @renderall()

      render: ->
        @$el.html @browseHtml

      renderall: ->
        $("#all-container").html @recipeListHtml
          recipes: @all.for_template()
          listId: "normal-recipe"

