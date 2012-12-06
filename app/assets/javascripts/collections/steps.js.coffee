
define ["lodash"
        "backbone"
        "models/step"
        "views/recipeStep"], 
  (_, Backbone, Step, RecipeStepView) ->

    StepsCollection = Backbone.Collection.extend
      model: Step

      initialize: ->
        @_stepViews = []

      comparator: (step) ->
        step.get("start_time")

      render: ({with_template}) ->
        if with_template
          @each (step) =>
            @_stepViews.push new RecipeStepView 
              model: step
              with_template: with_template

      get_view:(_model) ->
        _.find @_stepViews, (view) -> view.model is _model
