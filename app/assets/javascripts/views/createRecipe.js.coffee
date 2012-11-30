define ["backbone", "handlebars", "lodash", "jquery", "jquery.simplemodal",
        "models/recipe", "models/recipe_ingredient", "models/step",
        "collections/steps", "collections/recipe_ingredients",
        "views/recipeTimeline", "views/recipeIngredients",
        "text!templates/createRecipe.html"],
  (Backbone, Handlebars, _, $, simplemodal, Recipe, RecipeIngredient, Step,
   StepList, RecipeIngredients, Timeline, IngredientList, createRecipeTemplate) ->

    class CreateRecipeView extends Backbone.View
      events:
        'mouseover .editable': 'highlight'
        'mouseout .editable': 'unhighlight'
        'mouseover li.ingredient-editable': 'highlight'
        'mouseout li.ingredient-editable': 'unhighlight'
        'click #new-ingredient': 'createIngredient'
        'dblclick #ingredient-list li.ingredient-editable': 'editIngredient'
        'dblclick .editable': 'edit'
        'mouseover .contents-container .contents': 'highlight'
        'mouseout .contents-container .contents': 'unhighlight'
        'dblclick .contents-container .contents': 'editStep'
        'click .unit': 'addStep'
        'click a#favorite-recipe-button': 'favorite'
        'click a#unfavorite-recipe-button': 'unfavorite'
        'click a#publish-recipe-button': 'publish'
        'click a#unpublish-recipe-button': 'unpublish'
        'click a#delete-recipe-button': 'delete'
        # currently not working because element is created after
        # the rendering
        # 'click #submit-create-recipe': 'saveRecipe'

      initialize: (params) ->
        @template = Handlebars.compile createRecipeTemplate
        if params? && params.id?
          @model = new Recipe { _id: params.id }
          @model.fetch
            success: =>
              @render()
        else
          @model = new Recipe
            name: "Double click here to edit the recipe name."
            photo: "http://freecoloringpagesite.com/coloring-pics/blue-coloring-2.png"
            description: "Double click here to edit the recipe description. Additionally, you can double click any thing on this recipe to edit it."
            prep_time: "0"
            cook_time: "0"
            ready_in: "0"
            serving_size: "0"
            recipe_ingredients: new RecipeIngredients
            steps: new StepList [
              new Step { description: "Click here to edit this step.", start_time: 0, end_time: 30 }
            ]

      render: ->
        @$el.html @template @model.for_template()
        $(".recipe").ready => # check random element in template to make sure this exists
          $(".img-circle").first().css "background", "url('#{@model.attributes.photo}')"
          @renderIngredients()
          @renderTimeline()
          @renderFormActions()

      renderFormActions: ->
        $("#submit-create-recipe").on "click", (e) =>
          e.preventDefault()
          @saveRecipe()
          false

      renderIngredients: ->
        console.log "Rendered Ingredients"
        ingredients = @model.get "recipe_ingredients"
        _.each ingredients.models, (ing) ->
          ing.set "cid", ing.cid
        @ingredientsList = new IngredientList ingredients
        $(".ingredient-contents").ready =>
          $("#ingredient-list li").addClass "ingredient-editable"
          $("#ingredient-list").append "<li style='list-style-type: none;'>
                                      <a href='#' id='new-ingredient'>
                                      + Add Ingredient</a></li>"

      renderTimeline: ->
        steps = @model.get("steps")
        if steps.toJSON?
          @timeline = new Timeline steps.toJSON()
        else
          @timeline = new Timeline steps

      highlight: (e) ->
        if $(e.target).hasClass "img-circle"
          $(e.target).css "border-color", "#ffff99"
        else
          $(e.target).css "background", "#ffff99"
        $(e.target).css "color", "#478dff"

      unhighlight: (e) ->
        if $(e.target).hasClass "img-circle"
          $(e.target).css "border-color", "#fff"
        else
          $(e.target).css "background", "none"
        $(e.target).css "color", "black"

      edit: (e) ->
        e.preventDefault()
        type = $(e.target).attr "data-edit"
        field = $(e.target).attr "data-field"
        html = "<form id='edit-recipe-field-form'>"
        text = @model.get field

        if type is "textarea"
          html += "<textarea name='edit' rows=6 cols=60>#{text}</textarea>
                  <br /><br/><input type='submit' class='submit-button'>"
        else
          html +=  "<input type='text' name='edit' value='#{text}' size=60/>
                  <br /><br /><input type='submit' class='submit-button'>"
        html += "</form>"

        $.modal html, onShow: (dialog) =>
          $('#edit-recipe-field-form').on 'submit', (e) =>
            e.preventDefault()
            @model.set field, $("input[name=edit], textarea[name=edit]").val()
            $.modal.close()
            @render()
            false

      editIngredient: (e) ->
        e.preventDefault()
        html = "<form id='edit-ingredient-form'>
                  <p><input type='text' name='amount' placeholder='Amount'/></p>
                  <p><input type='text' name='unit' placeholder='Unit'/></p>
                  <p><input type='text' name='name' placeholder='Name'/></p>
                  <input type='submit'>
                </form>"
        $.modal html, onShow: (dialog) =>
          recipe_ingredients = @model.get "recipe_ingredients"
          console.log recipe_ingredients
          ingredient = recipe_ingredients.getByCid $(e.target).closest('.ingredient-editable').attr("data-cid")

          $('input[name=amount]').val ingredient.get 'amount'
          $('input[name=unit]').val ingredient.get 'unit'
          $('input[name=name]').val ingredient.get 'name'
          $("#edit-ingredient-form").on 'submit', (e) =>
            e.preventDefault()
            ingredient.set "amount", $('input[name=amount]').val()
            ingredient.set "unit", $('input[name=unit]').val()
            ingredient.set "name", $('input[name=name]').val()
            $.modal.close()
            @renderIngredients()
            false

      createIngredient: (e) ->
        e.preventDefault()
        html = "<form id='create-ingredient-form'>
                  <p><input type='text' name='amount' placeholder='Amount'/></p>
                  <p><input type='text' name='unit' placeholder='Unit'/></p>
                  <p><input type='text' name='name' placeholder='Name'/></p>
                  <input type='submit'>
                </form>"
        $.modal html, onShow: (dialog) =>
          $('#create-ingredient-form').on 'submit', (e) =>
            e.preventDefault()
            ings = @model.get "recipe_ingredients"
            amount = $("input[name=amount]").val()
            unit = $("input[name=unit]").val()
            name = $("input[name=name]").val()
            rIng = new RecipeIngredient
              amount: amount
              unit: unit
              name: name
            rIng.set "cid", rIng.cid
            ings.push rIng
            @model.set "recipe_ingredients", ings
            $.modal.close()
            @renderIngredients()
            false
        false

      editStep: (e) ->
        e.preventDefault()
        text = $(e.target).text().trim()
        html = "<form id='edit-step-form'>
                  <textarea name='step' rows=5 cols=40>#{text}</textarea>
                  <br />
                  <br />
                  <input type='submit'>
                </form>"
        $.modal html, onShow: (dialog) =>
          $('#edit-step-form').on 'submit', (e) =>
            e.preventDefault()
            steps = @model.get "steps"
            step = steps.where(description: text)[0]
            new_text = $("textarea[name='step']").val()
            step.set "description", new_text
            $.modal.close()
            @renderTimeline()

      addStep: (e) ->
        e.preventDefault()
        html = "<form id='add-step-form'>
                  <textarea name='description' rows=5 cols=40></textarea>
                  <br />
                  <p>
                  <input type='text' name='start_time' placeholder='Start time'/><br />
                  <input type='text' name='end_time' placeholder='End time'/><br />
                  </p>
                  <br />
                  <input type='submit'>
                </form>"
        $.modal html, onShow: (dialog) =>
          $('#add-step-form').on 'submit', (e) =>
            e.preventDefault()
            description = $("textarea[name=description]").val()
            start_time = $("input[name=start_time]").val()
            end_time = $("input[name=end_time]").val()
            steps = @model.get "steps"
            steps.push new Step
              description: description
              start_time: start_time
              end_time: end_time
            @model.set "steps", steps
            $.modal.close()
            @renderTimeline()

      saveRecipe: ->
        recipe_collection = @model.get "recipe_collection"
        steps = @model.get "steps"
        @model.save null,
          success: =>
            console.log "Saved"
            @renderIngredients()
          error: ->
            console.log "Error"

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
          error: ->
            alert "Error!"
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
          error: ->
            alert "Error!"
        false

      publish: (e) ->
        e.preventDefault()
        @model.set "published", true
        @model.save null
          success: =>
            $("#publish-recipe-button").text("Unpublish").attr("id", "unpublish-recipe-button")
          error: =>
            alert "Error!"
        # $.ajax
        #   type: 'POST'
        #   url: "/api/recipes/publish/#{@model.get '_id'}"
        #   dataType: "json"
        #   data:
        #     authenticity_token: $("meta[name='csrf-token']").attr "content"
        #   success: =>
        #     $("#publish-recipe-button").text("Unpublish").attr("id", "unpublish-recipe-button")
        #     @model.set "published", true
        #   error: ->
        #     alert "Error!"
        false

      unpublish: (e) ->
        e.preventDefault()
        @model.set "published", false
        @model.save null
          success: =>
            $("#unpublish-recipe-button").text("Publish").attr("id", "publish-recipe-button")
          error: =>
            alert "Error!"
        false

      delete: (e) ->
        e.preventDefault()
        @model.destroy
          success: =>
            window.router.navigate "/recipes",
              trigger: true
          error: =>
            alert "Error!"
        false
