
define ["backbone"
        "handlebars"
        "models/recipe"
        "views/recipeTimeline"
        "text!templates/recipe.html"],
  (Backbone, Handlebars, Recipe, Timeline, recipeTemplateHtml) ->

    class RecipeView extends Backbone.View
      steps: []
      timelineEl: "#timeline-container"

      initialize: (params) ->
        @template = Handlebars.compile recipeTemplateHtml
        @model = new Recipe {_id: params.id}
        @model.fetch
          success: =>
            _.each @model.attributes.steps, (step) =>
              @steps.push step
            @render()
            @renderTimeline()

      render: ->
        @$el.html @template @model.for_template()
        $(".img-circle").first().css "background", "url('#{@model.attributes.photo}')"

      renderTimeline: ->
        timeLine = new Timeline(@steps)
