define ["backbone"
        "handlebars"
        "models/recipe"
        "collections/recipe_ingredients"
        "text!templates/recipeIngredients.html"],
  (Backbone, Handlebars, Recipe, Ingredients, ingredientListTemplate) ->
    class RecipeIngredientListView extends Backbone.View
      el: "#icontainer"
      initialize: (ingredients) ->
        if ingredients.toJSON?
          @ingredients = ingredients
        else
          @ingredients = new Ingredients ingredients
        @template = Handlebars.compile ingredientListTemplate
        @render()

      render: ->
        $("#icontainer").html @template
          ingredients: @ingredients.toJSON()
