
define ["lodash"
        "backbone"
        "models/comment"],
  (_, Backbone, Comment) ->

    CommentsCollection = Backbone.Collection.extend
      model: Comment
      el: "#comments"

      initialize: ->
        @_commentViews = []
        @render()

      render: ({with_template}={}) ->
        $(@el).html "<div></div>"
        @each (comment) =>
          commentView = new CommentView
            model: @model
            with_template: with_template
          @$el.append commentView.render()
          @_commentViews.push commentView
        @

      for_template: ->
        _.map @models, (recipe) -> recipe.for_template()

      get_view:(_model) ->
        _.find @_commentViews, (view) -> view.model is _model

