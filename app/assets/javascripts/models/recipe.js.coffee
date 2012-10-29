define ["backbone"], (Backbone) ->

  class Recipe extends Backbone.Model
    idAttribute: "_id"
    urlRoot: "/api/recipes"

    schema: 
      name: 'Text'
      prep_time: 'Number'
      cook_time: 'Number'
      serving_size: 'Number'

    permalink: ->
      "recipes/#{@id}"

    initialize: ->

    for_template: ->
      json = @toJSON()
      json.url = @permalink()
      json
