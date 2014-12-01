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
    
  App.EpicEditor = new EpicEditor(editorOptions).load()
  App.EpicEditor.reset = -> @importFile()

Template.TicketUpdatesPartial.events
  'click .close': (e, tpl)-> Meteor.call 'ticketsDeleteUpdate', @_id
