
define ["backbone"
        "handlebars"
        "text!templates/test.html"], 
  (Backbone, Handlebars, testTemplateHtml) ->

    class RecipeView extends Backbone.View
      initialize: ->
        @template = Handlebars.compile testTemplateHtml
        @render()

      render: ->
        @$el.html @template