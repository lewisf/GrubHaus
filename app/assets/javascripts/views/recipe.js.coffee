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
