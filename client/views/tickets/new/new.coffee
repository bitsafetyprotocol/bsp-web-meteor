Template.TicketsNew.rendered = ->
  initEditor = ->
    editorOptions =
      container: 'epicEditor'
      basePath: ''
      autogrow: true
      theme:
        base: '/epiceditor/themes/base/epiceditor.css'
        preview: '/epiceditor/themes/preview/github.css'
        editor: '/epiceditor/themes/editor/epic-light.css'
      clientSideStorage: false

    App.EpicEditor = new EpicEditor(editorOptions).load()

  Meteor.setTimeout initEditor, 100

AutoForm.hooks
  newTicket:
    onSuccess: (operation, result, template) ->
      Router.go 'tickets.show', result
