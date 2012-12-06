
define ["jquery"
        "lodash"
        "backbone"
        "handlebars"
        "collections/comments"
        "text!templates/commentList.html"],
  ($, _, Backbone, Handlebars, commentsCollection, commentListTemplate) ->
    commentListView = Backbone.View.extend
      initialize: ->
        @template = Handlebars.compile commentListTemplate
        @collection.on 'add', @onCommentAdded, @

        commentList = @collection.fetch
          data: $.param {parent: @collection.parent}
          success: =>
            @render()

      render: ->
        @$el.html @template {comments: @collection.for_template()}
        @

      onCommentAdded: (addedModel) ->
        @$('ul').append "<li>#{addedModel.get('content')}</li>"


