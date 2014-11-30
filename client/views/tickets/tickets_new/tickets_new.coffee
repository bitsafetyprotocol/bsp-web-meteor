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

Template.TicketsNew.destroyed = ->

AutoForm.hooks
  newTicket:
    onSuccess: (operation, result, template) ->
      Router.go 'tickets.show', result
