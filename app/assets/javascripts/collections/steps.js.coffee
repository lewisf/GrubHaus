
define ["lodash"
        "backbone"
        "models/step"], (_, Backbone, Step) ->

  StepsCollection = Backbone.Collection.extend
    model: Step
