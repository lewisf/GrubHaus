define ["backbone",
        "models/comment"
        "collections/comments"], 
  (Backbone, Comment, CommentsCollection) ->
    class Step extends Backbone.Model
      idAttribute: "_id"
      schema:
        description: 'Text'
        start_time: 'Text'
        end_time: 'Text'

      initialize: ->
        comments = new CommentsCollection {parent: @id}
        @set "comments", comments

      for_template: ->
        @toJSON()

