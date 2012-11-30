
define ["lodash"
        "backbone"
        "models/recipe"], (_, Backbone, Recipe) ->
          
  RecipesCollection = Backbone.Collection.extend
    url: "/api/recipes#index"
    model: Recipe

    initialize: (params) ->
      @url = params.url if params

    for_template: ->
      _.map @models, (recipe) -> recipe.for_template()
