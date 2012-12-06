
define ["lodash"
        "backbone"
        "models/comment"],
  (_, Backbone, Comment) ->

    CommentsCollection = Backbone.Collection.extend
      model: Comment
      url: "/api/comments#index"

      initialize: ({parent}) ->
        @parent = parent

      for_template: ->
        _.map @models, (comment) -> comment.for_template()
