
define ["backbone"
        "handlebars"
        "models/comment"
        "text!templates/comment.html"],
  (Backbone, Handlebars, Comment, commentTemplate) ->
    class CommentView extends Backbone.View
      el: ".comment"
      events: 
        "click a.add-comment-button": "addComment"

      initialize: ({with_template}={commentTemplate}) ->
        @template = Handlebars.compile with_template

      render: (context={}) ->
        $(@el).html @template context
