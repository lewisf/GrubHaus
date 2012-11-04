define ["backbone"], (Backbone) ->

  class Recipe extends Backbone.Model
    idAttribute: "_id"
    urlRoot: "/api/recipes"

    schema: 
      name: ['Text']
      prep_time: ['Number',
	verbose: "Preparation Time"
	choices: [1,2,5,10,20,30,45,60,120]
      ]
      cook_time: ['Number',
	verbose: "Cook Time"
	choices: [1,2,5,10,20,30,45,60,120]
      ]
      serving_size: ['Number',
	verbose: "Serving Size"
	choices: ["1", "1-2", "2-4", "4-8"]
      ]

    permalink: ->
      "recipes/#{@id}"

    initialize: ->

    for_template: ->
      json = @toJSON()
      json.url = @permalink()
      json
