define ["backbone"],
  (Backbone) ->

    class UserProfile extends Backbone.Model
      idAttribute: "_id"

      url: ->
        if @get('_id')?
          "/api/users/#{@get '_id'}"
        else
          "/api/user"
