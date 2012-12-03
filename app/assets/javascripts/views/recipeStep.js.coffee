define ["backbone"
        "handlebars"
        "text!templates/addStepComment.html"],
  (Backbone, Handlebars, addStepCommentTemplate) ->
    class RecipeStepView extends Backbone.View
      el: ".recipe-step"
      events: 
        "click a.add-comment-button": "addComment"

      initialize: ({with_template}) ->
        @template = Handlebars.compile with_template
        @commentTemplate = Handlebars.compile addStepCommentTemplate

      render: (context={}) ->
        $(@el).html @template context

      addComment: ->
        commentTemplate = @commentTemplate @model.for_template()
        $.modal commentTemplate, onShow: (dialog) =>
          $("#add-step-comment-form").on 'submit', (e) =>
            e.preventDefault()          

            debugger
            false
        false

