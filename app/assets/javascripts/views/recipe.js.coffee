
define ["backbone"
        "handlebars"
        "models/recipe"
        "text!templates/recipe.html"], 
  (Backbone, Handlebars, Recipe, testTemplateHtml) ->

    class RecipeView extends Backbone.View
      initialize: (params) ->
        @template = Handlebars.compile testTemplateHtml
        @model = new Recipe {_id: params.id}
        @model.fetch
          success: =>
            @render()

      render: ->
        @$el.html @template @model.for_template()