# TicketsNew: Event Handlers and Helpers
Template.TicketsNew.events
# Example:
#  "click .selector": (e, tmpl) ->
#

Template.TicketsNew.helpers
  ticketSchema: -> Schemas.Ticket
# Example:
#   items: ->
#

# TicketsNew: Lifecycle Hooks
Template.TicketsNew.created = ->

Template.TicketsNew.rendered = ->
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


Template.TicketsNew.destroyed = ->

AutoForm.hooks
  newTicket:
    onSuccess: (operation, result, template) ->
      Router.go 'tickets.show', result
