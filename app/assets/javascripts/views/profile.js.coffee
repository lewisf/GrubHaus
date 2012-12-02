define ["backbone"
        "handlebars"
        "models/user_profile"],
  (Backbone, Handlebars, UserProfile) ->

    class ProfileView extends Backbone.View
      
      initialize: ->
        @model = new UserProfile
        @render()

      render: ->
