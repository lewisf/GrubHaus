define ["backbone"
        "handlebars"
        "models/recipe"
        "text!templates/timeline.html"
        "text!templates/timelineCircle.html"
        "text!templates/timelineLine.html"],
  (Backbone, Handlebars, Recipe, timelineTemplate, circleTemplate, lineTemplate) ->
    class RecipeTimelineView extends Backbone.View
      steps: []
      num_units: null
      timeListId: "time-unit-list"
      stepListId: "step-unit-list"
      start_times: []
      end_times: []
      el: "#rcontainer"
      scaling: true

      initialize: (steps) ->
        @timelineTemplate = Handlebars.compile timelineTemplate
        @lineTemplate = Handlebars.compile lineTemplate
        @circleTemplate = Handlebars.compile circleTemplate

        @steps = _.sortBy steps, (step) -> step.start_time

        @num_units = (_.max @steps, (step) -> step.end_time).end_time
        @start_times = _.map _.pluck(@steps, 'start_time'), (time) -> parseInt(time)
        @end_times = _.map _.pluck(@steps, 'end_time'), (time) -> parseInt(time)

        @render()

      render: ->
        $(@el).html(@timelineTemplate)
        @buildTimeline()

      buildTimeline: ->
        for i in [0..@num_units]
          steps = _.filter @steps, (step) -> parseInt(step.start_time) is i
          time_markers = _.union @start_times, {} #, @end_times
          if i in time_markers
            $("##{@timeListId}").append @circleTemplate
              index: i
              circleText: i
              color: "#930202"
              text: (_.pluck steps, 'description').join(" ")
          else if @scaling
            $("##{@timeListId}").append @lineTemplate
              index: i
