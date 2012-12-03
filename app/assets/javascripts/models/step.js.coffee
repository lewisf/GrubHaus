define ["backbone",
        "models/comment"], (Backbone, Comment) ->
  
  class Step extends Backbone.Model
    idAttribute: "_id"
    schema:
      description: 'Text'
      start_time: 'Text'
      end_time: 'Text'
      comments:
        type: "NestedModel"
        model: Comment

    for_template: ->
      @toJSON()

