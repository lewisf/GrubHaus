define ["backbone"], (Backbone) ->
  
  class RecipeIngredient extends Backbone.Model
    idAttribute: "_id"
    schema:
      amount: 'Text'
      unit: 'Text'
      name: 'Text'
