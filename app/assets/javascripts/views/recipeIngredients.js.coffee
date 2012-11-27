define ["backbone"
        "handlebars"
        "models/recipe"
        "text!templates/recipeIngredients.html"],
  (Backbone, Handlebars, Recipe, ingredientListTemplate) ->
    class RecipeIngredientListView extends Backbone.View
      el: "#icontainer"
      initialize: (ingredients) ->
        @ingredients = ingredients
        @template = Handlebars.compile ingredientListTemplate
        @render()

      render: ->
        $("#icontainer").html @template
          ingredients: @ingredients.toJSON()
