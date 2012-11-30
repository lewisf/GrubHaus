define ["backbone"
        "handlebars"
        "models/recipe"
        "views/recipeTimeline"
        "views/recipeIngredients"
        "text!templates/recipe.html"],
  (Backbone, Handlebars, Recipe, Timeline, IngredientList, recipeTemplateHtml) ->

    class RecipeView extends Backbone.View
      steps: []
      timelineEl: "#rcontainer"

      events:
        'click a#favorite-recipe-button': 'favorite'
        'click a#unfavorite-recipe-button': 'unfavorite'

      initialize: (params) ->
        @template = Handlebars.compile recipeTemplateHtml
        @model = new Recipe {_id: params.id}
        @model.fetch
          success: =>
            # check for problems here. if you remove @steps = []
            # and then click on a recipe, dashboard, then another
            # recipe, the steps are stacking. This isn't right
            # behavior .. something is lingering.
            @steps = []
            _.each @model.attributes.steps, (step) =>
              @steps.push step
            @render()
            @renderTimeline()
            @renderIngredients()

      render: ->
        console.log @model
        @$el.html @template @model.for_template()
        $(".img-circle").first().css "background", "url('#{@model.attributes.photo}')"

      renderTimeline: ->
        timeLine = new Timeline(@steps)

      renderIngredients: ->
        ingredientsList = new IngredientList @model.get("recipe_ingredients")

      favorite: (e) ->
        e.preventDefault()
        $.ajax
          type: 'POST'
          url: "/api/recipes/favorite/#{@model.get '_id'}"
          dataType: "json"
          data:
            authenticity_token: $("meta[name='csrf-token']").attr "content"
          success: =>
            $("#favorite-recipe-button").text("Unfavorite").attr("id", "unfavorite-recipe-button")
            @model.set "is_favorited_by_user?", true
          error: ->
            alert "Error!"
        false

      unfavorite: (e) ->
        e.preventDefault()
        $.ajax
          type: 'POST'
          url: "/api/recipes/unfavorite/#{@model.get '_id'}"
          dataType: "json"
          data:
            authenticity_token: $("meta[name='csrf-token']").attr "content"
          success: =>
            $("#unfavorite-recipe-button").text("Favorite").attr("id", "favorite-recipe-button")
            @model.set "is_favorited_by_user?", false
          error: ->
            alert "Error!"
        false
