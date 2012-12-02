define ["backbone"
        "handlebars"
        "models/user_profile",
        "text!templates/profile.html"],
  (Backbone, Handlebars, UserProfile, profileHtml) ->

    class ProfileView extends Backbone.View
      
      initialize: (params) ->
        @template = Handlebars.compile profileHtml
        if params.id?
          @model = new UserProfile {_id: params.id}
        else
          @model = new UserProfile

        @model.fetch
          success: =>
            @render()

      render: ->
        @$el.html @template @model.toJSON()
        
