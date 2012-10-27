
define ["backbone"], (Backbone) ->

  class RecipeView extends Backbone.View
    initialize: ->
      @render()

    render: ->
      @$el.html "<div>okay</div>"