define ["jquery", 
        "lodash", 
        "backbone",
        "handlebars",
        # "GrubHaus",
        "backbone.layoutmanager"], 
  ($, _, Backbone, Handlebars) ->
  # ($, _, Backbone, Handlebars, GrubHaus) ->
    app = {root: "/"}

    JST = window.JST ||= {}

    Backbone.LayoutManager.configure
      manage: true
      prefix: "app/templates"
      fetch: (path) ->
        path = "#{path}.html"

        if JST[path]
          return JST[path]

        done = @async()

        unless JST[path]
          $.get app.root+path, (contents) ->
            JST[path] = Handlebars.compile contents
            JST[path].__compiled__ = true
            done JST[path] 

        unless JST[path].__compiled__
          JST[path] = Handlebars.template JST[path]
          JST[path].__compiled__ = true

        return JST[path]

    _.extend app, {
      module: (additionalProps) ->
        _.extend {Views: {}}, additionalProps
      useLayout: (name, options) ->
        if @layout and @layout.options.template is name
          return @layout

        if @layout
          @layout.remove()

        layout = new Backbone.Layout _.extend {
          template: name,
          className: "layout#{name}",
          id: "layout",
        }, options

        $("#main").empty().append layout.el
        layout.render()
        @layout = layout
        return layout
    }, Backbone.Events

