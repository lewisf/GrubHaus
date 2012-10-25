require ["Backbone"], (Backbone) ->

  class Recipe extends Backbone.Model
    urlRoot: "/recipes"
    initialize: ->