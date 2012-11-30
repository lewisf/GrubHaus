define ["backbone"
        "models/recipe_ingredient"
        "models/step"],
  (Backbone, RecipeIngredient, Step) ->

    class Recipe extends Backbone.Model
      idAttribute: "_id"
      urlRoot: "/api/recipes"

      schema:
        name: 'Text'
        photo: 'Text'
        description: 'Text'
        "Prep time": 'Text'
        "Cook time": 'Text'
        "Ready In": 'Text'
        serving_size: 'Text'
        "Recipe Ingredients":
          type: 'NestedModel'
          model: RecipeIngredient
        steps:
          type: 'NestedModel'
          model: Step

      permalink: ->
        "recipes/#{@id}"

      initialize: ->

      for_template: ->
        json = @toJSON()
        json.url = @permalink()
        json
