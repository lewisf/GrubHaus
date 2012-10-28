define ["backbone"], (Backbone) ->

  class Recipe extends Backbone.Model
    idAttribute: "_id"
    urlRoot: "/api/recipes"
    permalink: ->
      "recipes/#{@id}"

    initialize: ->

    for_template: ->
      json = @toJSON()
      json.url = @permalink()
      json
