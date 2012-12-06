
define ["backbone"
        "handlebars"
        "models/comment"
        "text!templates/addComment.html"],
  (Backbone, Handlebars, Comment, addCommentTemplate) ->
    class AddCommentView extends Backbone.View
      initialize: ({parent}) ->
        @parent = parent
        @model = Comment

        @commentTemplate = Handlebars.compile addCommentTemplate

      render: ->
        @$el.html @commentTemplate @parent
        @

      save: ->
        content = $("textarea[name=content]").val()
        comment = new Comment {content: content, parent: @parent.id}
        comments = @parent.get "comments"
        comments.add comment
        comment.save()
        @render()
