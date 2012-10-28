require ["backbone"], (Backbone) ->

  class Recipe extends Backbone.Model
    urlRoot: "/recipes"
    initialize: ->
      alert 'wat'