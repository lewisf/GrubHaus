define ["backbone"
        "handlebars"
        "models/recipe"
        "text!templates/timelineCircle.html"
        "text!templates/timelineLine.html"],
  (Backbone, Handlebars, Recipe, circleTemplate, lineTemplate) ->
    class RecipeTimelineView extends Backbone.View
      steps: []
      num_units: null
      timeListId: "time-unit-list"
      stepListId: "step-unit-list"

      initialize: (steps) ->
        @lineTemplate = Handlebars.compile circleTemplate
        @circleTemplate = Handlebars.compile lineTemplate
        @steps = _.sortBy steps, (step) -> step.start_time
        @num_units = (_.max @steps, (step) -> step.end_time).end_time
        console.log @num_units
        @render()

      render: ->
        @buildTimeline()
        @buildSteps

      buildTimeline: ->
        # $("#container").html "<ul id='#{@timeListId}'></ul><ul id='#{@stepListId}'></ul>"

        #for i in [0..@num_units]
        for i in [0..@num_units]
          unless i % 10 is 0
            $("##{@timeListId}").append @circleTemplate
              index: i
          else
            $("##{@timeListId}").append @lineTemplate
              index: i

      buildSteps: ->
        for i in [0..@num_units]
          _.each @steps, (step) =>
            if parseInt step.start_time is i
              @renderStepAt i, step

      renderStepAt: (index, step) ->
        $("#step-minute-#{index}").html step.description


