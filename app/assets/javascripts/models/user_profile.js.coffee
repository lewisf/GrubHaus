define ["backbone"],
  (Backbone) ->

    class UserProfile extends Backbone.Model
      idAttribute: "_id"

      urlRoot: ->
        if @get('_id')?
          "/api/users/profile/#{@get '_id'}"
        else
          "/api/user"
