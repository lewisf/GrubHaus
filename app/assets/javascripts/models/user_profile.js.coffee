define ["backbone"],
  (Backbone) ->

    class UserProfile extends Backbone.Model
      idAttribute: "_id"
      urlRoot: "/api/users/#{@get '_id'}"

      urlRoot: ->
        if @model.get('_id')?
          "/api/users/profile/#{@get '_id'}"
        else
          "/api/users/profile"
