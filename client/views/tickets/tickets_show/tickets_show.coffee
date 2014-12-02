Template.TicketsShow.events {}

Template.TicketsShow.helpers
  infoPanelClass: (status) ->
    switch status
      when 'new' then return 'panel-warning'
      when 'open' then return 'panel-info'
      when 'closed' then return 'panel-success'
      else return ''

Template.TicketsShow.created = ->

Template.TicketsShow.rendered = ->

Template.TicketsShow.destroyed = ->

Template.TicketShowCommentForm.helpers
  modKey: ->
    if navigator.platform.indexOf('Mac') >= 0 then 'Cmd' else 'Ctrl'

Template.TicketShowCommentForm.events
  'click .postComment': (e, tpl) ->
    id = @ticket()._id
    comment = tpl.$('#TicketCommentInput').val()
    Meteor.call 'ticketsPostComment', id, comment
    App.EpicEditor.reset()
    App.EpicEditor.focus()

Template.TicketShowCommentForm.rendered = ->
  editorOptions =
    container: 'epicEditor'
    basePath: ''
    autogrow: true
    theme:
      base: '/epiceditor/themes/base/epiceditor.css'
      preview: '/epiceditor/themes/preview/github.css'
      editor: '/epiceditor/themes/editor/epic-light.css'
    clientSideStorage: false
    
  editor = new EpicEditor(editorOptions)
  editor.load ->
    $(editor.editor).on 'keydown', (e) ->
      if (e.metaKey || e.ctrlKey) and e.keyCode is 13
        $('#ticketCommentForm .postComment').trigger 'click'
      true
  editor.reset = -> @importFile()
  App.EpicEditor = editor

Template.TicketUpdatesPartial.events
  'click .close': (e, tpl)-> Meteor.call 'ticketsDeleteUpdate', @_id
