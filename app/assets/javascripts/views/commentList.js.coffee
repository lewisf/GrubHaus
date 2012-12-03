
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

        # commentList = @collection.fetch
        #   success: =>
        #     @render()
        @render()


      render: ->
        @$el.html @template {comments: @collection.for_template()}
        @
