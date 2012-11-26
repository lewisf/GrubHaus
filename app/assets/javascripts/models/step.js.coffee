define ["backbone"], (Backbone) ->
  
  class Step extends Backbone.Model
    idAttribute: "_id"
    schema:
      description: 'Text'
      start_time: 'Text'
      end_time: 'Text'
