
define ["jquery"
        "lodash"
        "backbone"
        "handlebars"
        "collections/comments"
        "text!templates/commentList.html"
        "text!templates/comment.html"],
  ($, _, Backbone, Handlebars, commentsCollection, commentListTemplate, 
   commentTemplate) ->
    commentListView = Backbone.View.extend
      initialize: ->
        @template = Handlebars.compile commentListTemplate
        @commentTemplate = Handlebars.compile commentTemplate
        @collection.on 'add', @onCommentAdded, @

        commentList = @collection.fetch
          data: $.param {parent: @collection.parent}
          success: =>
            @render()

      render: ->
        commentTemplates = (@commentTemplate comment for comment in @collection.for_template())
        @$el.html @template {commentTemplates:commentTemplates}
        @

      onCommentAdded: (addedModel) ->
        json = addedModel.for_template()
        username = $("meta#current_user").attr 'user'
        json.author = {username: username}
        @$('ul').append @commentTemplate json
        @$('ul').scrollTop $('ul.comment-list')[0].scrollHeight


