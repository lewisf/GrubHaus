
define ["backbone"
        "handlebars"
        "models/recipe"
        "text!templates/createRecipe.html"],
  (Backbone, Handlebars, Recipe, createRecipeTemplate) ->

    class CreateRecipeView extends Backbone.View
      initialize: (params) ->
        @template = Handlebars.compile createRecipeTemplate
        @render()

      render: ->
        form_fields =
          for k, v of Recipe::schema
            {field: k, type: v}
        @$el.html @template {form_fields: form_fields}