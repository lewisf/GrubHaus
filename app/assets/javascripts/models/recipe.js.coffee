define ["backbone"], (Backbone) ->

  class Recipe extends Backbone.Model
    idAttribute: "_id"
    urlRoot: "/api/recipes"

    schema: 
      name: ['Text',
        verbose: 'Name'
      ]
      prep_time: ['Text',
      	verbose: "Preparation Time"
      ]
      cook_time: ['Text',
      	verbose: "Cook Time"
      ]
      serving_size: ['Text',
      	verbose: "Serving Size"
      ]

    permalink: ->
      "recipes/#{@id}"

    initialize: ->

    for_template: ->
      json = @toJSON()
      json.url = @permalink()
      json
