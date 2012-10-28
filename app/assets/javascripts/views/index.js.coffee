
define ["backbone"
        "handlebars"
        "text!templates/index.html"], 
  (Backbone, Handlebars, indexTemplateHtml) ->

    class IndexView extends Backbone.View
      initialize: ->
        @template = Handlebars.compile indexTemplateHtml
        @render()

      render: ->
        @$el.html @template