
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
        @render()

      render: ->
        @$el.html @commentTemplate @parent
        @

      save: ->
        content = $("input[name=content]").val()
        comment = new Comment {content: content}
        comments = @parent.get("comments")
        comments.add comment
        comments.save()