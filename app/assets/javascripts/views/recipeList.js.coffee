
define ["jquery"
        "lodash"
        "backbone"
        "handlebars"
        "collections/recipes"
        "text!templates/recipeList.html"],
  ($, _, Backbone, Handlebars, RecipesCollection, recipeListTemplate) ->
    RecipeListView = Backbone.View.extend
      initialize: ->
        @collection = new RecipesCollection()
        @template = Handlebars.compile recipeListTemplate

        recipeList = @collection.fetch
          success: =>
            @render()

      render: ->
        @$el.html @template {recipes: @collection.for_template()}
