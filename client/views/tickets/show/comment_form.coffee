Template.TicketCommentForm.helpers
  modKey: ->
    if navigator.platform.indexOf('Mac') >= 0 then 'Cmd' else 'Ctrl'

Template.TicketCommentForm.events
  'click .postComment': (e, tpl) ->
    id = @ticket._id
    comment = tpl.$('#TicketCommentInput').val()
    Meteor.call 'ticketsPostComment', id, comment
    App.EpicEditor.reset()
    App.EpicEditor.focus()

Template.TicketCommentForm.rendered = ->
  editorOptions =
    container: 'epicEditor'
    basePath: ''
    autogrow: true
    theme:
      base: '/epiceditor/themes/base/epiceditor.css'
      preview: '/epiceditor/themes/preview/github.css'
      editor: '/epiceditor/themes/editor/epic-light.css'
    clientSideStorage: false

  initEditor = ->
    editor = new EpicEditor(editorOptions)
    editor.load ->
      $(editor.editor).on 'keydown', (e) ->
        if (e.metaKey || e.ctrlKey) and e.keyCode is 13
          $('#ticketCommentForm .postComment').trigger 'click'
        true
    editor.reset = -> @importFile()
    App.EpicEditor = editor

  Meteor.setTimeout initEditor, 100
