define ["backbone"
        "handlebars"
        "lodash"
        "jquery"
        "simplemodal"
        "models/recipe"
        "collections/steps"
        "models/step"
        "views/recipeTimeline"
        "views/recipeIngredients"
        "text!templates/createRecipe.html"],
  (Backbone, Handlebars, _, $, simplemodal, Recipe, StepList, Step, Timeline, IngredientList, createRecipeTemplate) ->

    class CreateRecipeView extends Backbone.View
      events:
        'dblclick .editable': 'edit'
        'mouseover .editable': 'highlight'
        'mouseout .editable': 'unhighlight'
        'click #new-ingredient': 'createIngredient'
        'mouseover .contents-container .contents': 'highlight'
        'mouseout .contents-container .contents': 'unhighlight'
        'dblclick .contents-container .contents': 'editStep'
        'click .unit': 'addStep'
        # currently not working because element is created after
        # the rendering
        # 'click #submit-create-recipe': 'saveRecipe'

      initialize: (params) ->
        @template = Handlebars.compile createRecipeTemplate
        @model = new Recipe
          name: "Double click here to edit the recipe name."
          photo: "http://freecoloringpagesite.com/coloring-pics/blue-coloring-2.png"
          description: "Double click here to edit the recipe description. Additionally, you can double click any thing on this recipe to edit it."
          prep_time: "0"
          cook_time: "0"
          ready_in: "0"
          serving_size: "0"
          recipe_ingredients: []
          steps: new StepList [
            new Step { description: "Click here to edit this step.", start_time: 0, end_time: 30 }
          ]

      createRecipe: (e) ->
        e.preventDefault()
        form = $(e.currentTarget).serializeArray()
        params = _(form).chain().map((x) -> _(x).values()).object().value()
        recipe = new Recipe params
        recipe.save()
        false

      render: ->
        @$el.html @template @model.for_template()
        $(".recipe").ready => # check random element in template to make sure this exists
          $(".img-circle").first().css "background", "url('#{@model.attributes.photo}')"
          @renderIngredients()
          @renderTimeline()
          @renderFormActions()

      renderFormActions: ->
        $("#wrap").prepend "<div id='form-actions'>
          <a style='color: white' href='#' id='submit-create-recipe'>Save Recipe</a>
        </div>"
        $("#submit-create-recipe").ready =>
          $("#submit-create-recipe").on "click", (e) =>
            e.preventDefault()
            @saveRecipe()
            false

      renderIngredients: ->
        @ingredientsList = new IngredientList(@model.get "recipe_ingredients")
        $(".ingredient-contents").ready =>
          $("#ingredient-list").append "<li style='list-style-type: none;'>
                                      <a href='#' id='new-ingredient'>
                                      + Add Ingredient</a></li>"

      renderTimeline: ->
        steps = @model.get("steps").toJSON()
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
          html += "<textarea name='edit' rows=5 cols=40>#{text}</textarea>
                  <br /><br/><input type='submit'>"
        else
          html +=  "<input type='text' name='edit' value='#{text}'/>
                  <br /><br /><input type='submit'>"
        html += "</form>"

        $.modal html, onShow: (dialog) =>
          $('#edit-recipe-field-form').on 'submit', (e) =>
            e.preventDefault()
            @model.set field, $("input[name=edit], textarea[name=edit]").val()
            $.modal.close()
            @render()
            false

      createIngredient: (e) ->
        e.preventDefault()
        html = "<form id='create-ingredient-form'>
                  <input type='text' name='amount' placeholder='amount'/><br/>
                  <input type='text' name='unit' placeholder='unit'/><br/>
                  <input type='text' name='name' placeholder='name'/><br/>
                  <br/>
                  <input type='submit'>
                </form>"
        $.modal html, onShow: (dialog) =>
          $('#create-ingredient-form').on 'submit', (e) =>
            e.preventDefault()
            ings = @model.get "recipe_ingredients"
            amount = $("input[name=amount]").val()
            unit = $("input[name=unit]").val()
            name = $("input[name=name]").val()
            ings.push
              amount: amount
              unit: unit
              name: name
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
        console.log "HAHA"
        @model.save()
