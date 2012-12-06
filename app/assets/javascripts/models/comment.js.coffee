
define ["backbone"], (Backbone) ->
  
  class Comment extends Backbone.Model
    idAttribute: "_id"
    urlRoot: "/api/comments"
    schema:
      content: 'Text'

    url: ->
      if @get('_id')?
        "/api/comments/#{@get '_id'}"
      else
        "/api/comments"

    for_template: ->
      @toJSON()

