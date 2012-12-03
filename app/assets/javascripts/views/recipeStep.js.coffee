define ["backbone"
        "handlebars"
        "views/addComment"
        "views/commentList"
        "text!templates/addStepComment.html"],
  (Backbone, Handlebars, AddCommentView, CommentListView, addStepCommentTemplate) ->
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

        commentListView = new CommentListView {collection: @model.comments}
        addCommentTemplate = new AddCommentView {parent: @model}
        context = 
          comments: commentListView.render().el.innerHTML
          comment_form: addCommentTemplate.render().el.innerHTML

        template = addStepCommentTemplate context 

        $.modal template, onShow: (dialog) ->
          $("#add-step-comment-form").on 'submit', (e) =>
            e.preventDefault()          
            addCommentTemplate.save()
            false
        false
