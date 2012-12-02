define ["backbone"
        "models/recipe_ingredient"
        "collections/recipe_ingredients"
        "collections/steps"
        "models/step"],
  (Backbone, RecipeIngredient, RecipeIngredients, Steps, Step) ->

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
        if json.is_authored_by_user
          json.url = "recipes/edit/#{@id}"
        else
          json.url = "recipes/#{@id}"
        json

      parse: (response, xhr) ->
        console.log response
        response.steps = new Steps response.steps

        ings = new RecipeIngredients response.recipe_ingredients
        response.recipe_ingredients = ings

        return response
