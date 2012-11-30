
define ["backbone"
        "handlebars"
        "text!templates/search.html"
        "text!templates/search_result_container.html"
        "text!templates/search_result.html"],
  (Backbone, Handlebars, indexTemplateHtml, searchResultContainerHtml, searchResultHtml) ->

    class IndexView extends Backbone.View

      query: ""
      events:
        'submit #search-form': 'doSearch'

      initialize: (q) ->
        @template = Handlebars.compile indexTemplateHtml
        @resContainerTemplate = Handlebars.compile searchResultContainerHtml
        @searchResultHtml = Handlebars.compile searchResultHtml
        @query = q
        @render()
        false

      render: ->
        @$el.html(@template({query: @query}))
        @doSearch()

      renderResults: (data) ->
        $("#wrap-push").append @resContainerTemplate if _.isEmpty $("#results-container")
        
        # Empty results list first
        $("#results-list").html ""
        
        _.each data, (recipe) =>
          recipe.description = recipe.description.substring(0, 150) + "..."
          $("#results-list").append @searchResultHtml(recipe)


      doSearch: (e) ->
        if e?
          e.preventDefault()
          @query = $("input[name=q]").val()
          window.router.navigate "recipes/search/#{@query}"
        unless _.isEmpty @query
          baseUrl = '/api/recipes/search.json'
          url = "#{baseUrl}?q=#{@query}"
          $.getJSON url, (data) =>
            @renderResults data
            @updateQueryIndicator @query
          false

      updateQueryIndicator: (queryString) ->
        $("span#q-ind").text queryString
