define ["backbone"
        "handlebars"
        "models/recipe"
        "views/recipeTimeline"
        "views/recipeIngredients"
        "text!templates/recipe.html"
        "helpers/flash"],
  (Backbone, Handlebars, Recipe, Timeline, IngredientList, recipeTemplateHtml, flash) ->

    class RecipeView extends Backbone.View
      steps: []
      timelineEl: "#rcontainer"

      events:
        'click a#favorite-recipe-button': 'favorite'
        'click a#unfavorite-recipe-button': 'unfavorite'
        'click a#fork-recipe-button': 'fork'
        'click a#edit-recipe-button': 'gotoEditRecipe'

      initialize: (params) ->
        @template = Handlebars.compile recipeTemplateHtml
        @model = new Recipe {_id: params.id}
        @model.fetch
          success: =>
            # check for problems here. if you remove @steps = []
            # and then click on a recipe, dashboard, then another
            # recipe, the steps are stacking. This isn't right
            # behavior .. something is lingering.
            @steps = []
            _.each @model.get("steps").toJSON(), (step) =>
              @steps.push step
            @render()
            @renderTimeline()
            @renderIngredients()

      render: ->
        @$el.html @template @model.for_template()
        $(".img-circle").first().css "background", "url('#{@model.attributes.photo}')"
        $(".img-circle").first().css "background-size", "cover"
        if @model.get("is_authored_by_user") or @model.get("current_user_is_admin")
          @renderEditButton()

      renderTimeline: ->
        timeLine = new Timeline(@steps)

      renderIngredients: ->
        ingredientsList = new IngredientList @model.get("recipe_ingredients")

      renderEditButton: ->
        $("#recipe-actions").append "<a href='#' id='edit-recipe-button'>Edit</a>"

      favorite: (e) ->
        e.preventDefault()
        $.ajax
          type: 'POST'
          url: "/api/recipes/favorite/#{@model.get '_id'}"
          dataType: "json"
          data:
            authenticity_token: $("meta[name='csrf-token']").attr "content"
          success: =>
            $("#favorite-recipe-button").text("Unfavorite").attr("id", "unfavorite-recipe-button")
            @model.set "is_favorited_by_user?", true
            flash.success "Favorited!"
          error: ->
            flash.error "Ugh, something went wrong."
        false

      unfavorite: (e) ->
        e.preventDefault()
        $.ajax
          type: 'POST'
          url: "/api/recipes/unfavorite/#{@model.get '_id'}"
          dataType: "json"
          data:
            authenticity_token: $("meta[name='csrf-token']").attr "content"
          success: =>
            $("#unfavorite-recipe-button").text("Favorite").attr("id", "favorite-recipe-button")
            @model.set "is_favorited_by_user?", false
            flash.success "Unfavorited. :("
          error: ->
            flash.error "Weird, we couldn't unfavorite this recipe. Please try again later."
        false

      fork: (e) ->
        e.preventDefault()
        $.ajax
          type: 'POST'
          url: "/api/recipes/fork/#{@model.get '_id'}"
          dataType: "json"
          data:
            authenticity_token: $("meta[name='csrf-token']").attr "content"
          success: (data) ->
            window.router.navigate "/recipes/edit/#{data._id}",
              trigger: true
            flash.success "Cool, we forked the recipe. This is now something you can edit and publish!"
          error: =>
            flash.error "Weird, we couldn't unfavorite this recipe. Please try again later."
        false

      gotoEditRecipe: (e) ->
        e.preventDefault()
        window.router.navigate "/recipes/edit/#{@model.get "_id"}", {trigger: true}
        false

