define [
  'jquery'
  'underscore'
  'backbone'
  'marionette'
  'cs!app'
  'cs!collections/content'
  'cs!views/layouts/Workspace'
  'less!styles/main.less'
], ($, _, Backbone, Marionette, app, content, WorkspaceLayout) ->

  return new (Marionette.Controller.extend
    # Show Workspace
    # -------
    # Show the workspace listing and update the URL
    workspace: () ->
      if not @layout
        @layout = new WorkspaceLayout()
        app.main.show(@layout)
      else
        # load default views
        @layout.load()

    # Edit existing content
    # -------
    # Start editing an existing piece of content and update the URL.
    edit: (model) ->
      if typeof model is 'string'
        model = content.get(model)

      # Redirect to workspace if model does not exist
      if not model
        require ['cs!routers/router'], (router) ->
          router.navigate('/', {trigger: true, replace: true});

      if not @layout
        @layout = new WorkspaceLayout({model: model})
        app.main.show(@layout)
      else
        # load editor views
        @layout.load({model: model})
  )()