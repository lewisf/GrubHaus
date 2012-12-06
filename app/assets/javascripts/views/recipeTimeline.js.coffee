define ["backbone"
        "handlebars"
        "models/recipe"
        "collections/steps"
        "text!templates/timeline.html"
        "text!templates/timelineCircle.html"
        "text!templates/timelineLine.html"],
  (Backbone, Handlebars, Recipe, StepsCollection, timelineTemplate, circleTemplate, lineTemplate) ->
    class RecipeTimelineView extends Backbone.View
      steps: []
      num_units: null
      timeListId: "time-unit-list"
      stepListId: "step-unit-list"
      start_times: []
      end_times: []
      el: "#rcontainer"
      scaling: true

      initialize: (recipe, creating=false) ->
        @recipe = recipe
        @creating = creating
        @timelineTemplate = Handlebars.compile timelineTemplate
        @lineTemplate = Handlebars.compile lineTemplate

        @steps = @recipe.get "steps"

        @start_times = _.map @steps.pluck("start_time"), (time) -> parseInt(time)
        @end_times = _.map @steps.pluck("end_time"), (time) -> parseInt(time)
        @num_units = _.max @end_times

        @steps.render {with_template: circleTemplate, creating: creating}

        @render()

      render: ->
        $(@el).html @timelineTemplate

        @buildTimeline()

      buildTimeline: ->
        for i in [0..@num_units]
          steps = @steps.filter (step) -> parseInt(step.get "start_time") is i
          time_markers = _.union @start_times, {} #, @end_times
          if i in time_markers
            for step in steps
              stepView = @steps.get_view step
              piece = $("##{@timeListId}").append("<div class='recipe-step #{step.id}'></div>")
              stepView.setElement(".recipe-step.#{step.id}").render
                index: i
                circleText: i
                color: "#930202"
                text: step.get "description"
                creating: @creating
          else if @scaling
            $("##{@timeListId}").append @lineTemplate
              index: i
