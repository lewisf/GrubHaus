define ["backbone", "models/recipe_ingredient"], (Backbone, RecipeIngredient) ->

  class RecipeCollection extends Backbone.Collection
    model: RecipeIngredient
