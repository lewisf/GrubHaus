define ["backbone"
        "handlebars"],
  (Backbone, Handlebars) ->
    class RecipeStepView extends Backbone.View
      el: "#recipe-step"

      initialize: ({with_template}) ->
        @template = Handlebars.compile with_template

      render: (context={}) ->
        @template context
