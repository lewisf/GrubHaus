
define ["backbone"], (Backbone) ->
  
  class Comment extends Backbone.Model
    idAttribute: "_id"
    schema:
      content: 'Text'
