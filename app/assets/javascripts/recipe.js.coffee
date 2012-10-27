
require ["backbone"], (Backbone) ->

  class RecipeView extends Backbone.View
    initialize: ->
      debugger
      @render()

    render: ->
      @$el.html "<div>okay</div>"