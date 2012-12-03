define ["backbone"
        "handlebars"
        "models/user_profile",
        "text!templates/profile_info.html"
        "jquery.simplemodal"],
  (Backbone, Handlebars, UserProfile, profileInfoHtml) ->

    class ProfileInfoView extends Backbone.View

      events:
        'mouseover .profile-editable h1': 'highlight'
        'mouseover .profile-editable h2': 'highlight'
        'mouseover .profile-editable h3': 'highlight'
        'mouseout  .profile-editable h1': 'unhighlight'
        'mouseout  .profile-editable h2': 'unhighlight'
        'mouseout  .profile-editable h3': 'unhighlight'
        'mouseover .profile-editable.img-circle': 'highlight'
        'mouseout .profile-editable.img-circle': 'unhighlight'
        'dblclick .profile-editable #name': 'editName'
        'dblclick .profile-editable #username': 'editUsername'
        'dblclick .profile-editable #tagline': 'editTagline'
        'dblclick .profile-editable #email': 'editEmail'
        'dblclick .profile-editable.img-circle': 'editPhoto'

      initialize: (params) ->
        @template = Handlebars.compile profileInfoHtml
        @model = params.model
        @render()

      render: ->
        @$el.html @template @model.toJSON()

      highlight: (e) ->
        if $(e.target).hasClass "img-circle"
          $(e.target).css "border-color", "#ffff99"
        else
          $(e.target).css "background", "#ffff99"
        $(e.target).css "color", "#478dff"

      unhighlight: (e) ->
        if $(e.target).hasClass "img-circle"
          $(e.target).css "border-color", "#fff"
        else
          $(e.target).css "background", "none"
        $(e.target).css "color", "black"

      editPhoto: (e)->
        e.preventDefault()
        html = "<form id='edit-profile-photo-form'>"
        html += "<input type='text' name='photo' value='#{@model.get("profile").photo}' size=60/>
               <br /><br />
               <input type='submit' class='submit-button'>"
        html += "</form>"

        $.modal html, onShow: (dialog) =>
          $("#edit-profile-photo-form").on "submit", (e) =>
            e.preventDefault()
            profile = @model.get "profile"
            profile.photo = $("input[name=photo]").val()
            @model.set "profile", profile
            @model.save()
            $.modal.close()
            @render()

      editName: (e) ->
        e.preventDefault()
        html = "<form id='edit-profile-name-form'>"
        html += "<input type='text' name='first_name' value='#{@model.get("profile").first_name}' size=60/>
               <br /><br />
               <input type='text' name='last_name' value='#{@model.get('profile').last_name}' size=60 />
               <br /><br />
               <input type='submit' class='submit-button'>"
        html += "</form>"

        $.modal html, onShow: (dialog) =>
          $("#edit-profile-name-form").on "submit", (e) =>
            e.preventDefault()
            profile = @model.get "profile"
            profile.first_name = $("input[name=first_name]").val()
            profile.last_name = $("input[name=last_name]").val()
            @model.set "profile", profile
            @model.save()
            $.modal.close()
            @render()

      editEmail: (e) ->
        e.preventDefault()
        html = "<form id='edit-profile-email-form'>"
        html += "<input type='text' name='email' value='#{@model.get("email")}' size=60/>
               <br /><br />
               <input type='submit' class='submit-button'>"
        html += "</form>"

        $.modal html, onShow: (dialog) =>
          $("#edit-profile-email-form").on "submit", (e) =>
            e.preventDefault()
            @model.set "email", $("input[name=email]").val()
            @model.save()
            $.modal.close()
            @render()

      editUsername: (e) ->
        e.preventDefault()
        html = "<form id='edit-profile-username-form'>"
        html += "<input type='text' name='username' value='#{@model.get("username")}' size=60/>
               <br /><br />
               <input type='submit' class='submit-button'>"
        html += "</form>"

        $.modal html, onShow: (dialog) =>
          $("#edit-profile-username-form").on "submit", (e) =>
            e.preventDefault()
            @model.set "username", $("input[name=username]").val()
            $.modal.close()
            @model.save()
            @render()

      editTagline: (e) ->
        e.preventDefault()
        html = "<form id='edit-profile-tagline-form'>"
        html += "<input type='text' name='tagline' value='#{@model.get("profile").tagline}' size=60/>
               <br /><br />
               <input type='submit' class='submit-button'>"
        html += "</form>"

        $.modal html, onShow: (dialog) =>
          $("#edit-profile-tagline-form").on "submit", (e) =>
            e.preventDefault()
            profile = @model.get "profile"
            profile.tagline = $("input[name=tagline]").val()
            @model.set "profile", profile
            $.modal.close()
            @model.save()
            @render()

