
define ["backbone"
        "handlebars"
	"lodash"
	"jquery"
        "models/recipe"
        "text!templates/createRecipe.html"],
  (Backbone, Handlebars, _, $, Recipe, createRecipeTemplate) ->

    class CreateRecipeView extends Backbone.View
      initialize: (params) ->
        @template = Handlebars.compile createRecipeTemplate
        @render()

      Handlebars.registerHelper 'form_field', ->
	new Handlebars.SafeString @field_el

      get_field = (field, type, {verbose, choices}={}) ->
	field_name = verbose or field
	field_el =
	  switch type
	    when "Text" then "<input id='#{field}' type='text'></input>"
	    when "Number"
	      if choices
		tag = $ "<select id='#{field}'></select>"
		for value, index in choices
		  tag.append "<option value='#{index}'>#{value}</option>"
		tag[0].outerHTML
	      else
		"<input id='#{field}' type='text'></input>"
	{field: field, field_name: field_name, field_el: field_el}

      render: ->
        form_fields =
          for k, v of Recipe::schema
	    get_field k, v...
        @$el.html @template {form_fields: form_fields}