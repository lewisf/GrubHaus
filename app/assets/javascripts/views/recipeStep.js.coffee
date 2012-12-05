define ["backbone"
        "handlebars"
        "views/addComment"
        "views/commentList"
        "models/comment"
        "text!templates/addStepComment.html"],
  (Backbone, Handlebars, AddCommentView, CommentListView, Comment, addStepCommentTemplate) ->
    class RecipeStepView extends Backbone.View
      el: ".recipe-step"
      events: 
        "click a.add-comment-button": "addComment"

      initialize: ({with_template}) ->
        @template = Handlebars.compile with_template

      render: (context={}) ->
        $(@el).html @template context

      addComment: ->
        addStepCommentTemplate = Handlebars.compile addStepCommentTemplate

        commentListView = new CommentListView 
          collection: @model.get "comments"

        addCommentView = new AddCommentView 
          parent: @model

        template = addStepCommentTemplate 
          comments: commentListView.render().el.innerHTML
          comment_form: addCommentView.render().el.innerHTML

        $.modal template, onShow: (dialog) ->
          commentListView.setElement "#comments"
          addCommentView.setElement "#comment-form"
          $("#add-step-comment-form").on 'submit', (e) =>
            e.preventDefault()          
            addCommentView.save()
            false
        false
