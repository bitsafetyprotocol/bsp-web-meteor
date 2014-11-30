# TicketsShow: Event Handlers and Helpers
Template.TicketsShow.events
  'click .setStatusNew':    -> Meteor.call 'ticketsSetStatus', @ticket()._id, 'new'
  'click .setStatusOpen':   -> Meteor.call 'ticketsSetStatus', @ticket()._id, 'open'
  'click .setStatusClosed': -> Meteor.call 'ticketsSetStatus', @ticket()._id, 'closed'

# Example:
#  "click .selector": (e, tmpl) ->
#

Template.TicketsShow.helpers
  infoPanelClass: (status) ->
    switch status
      when 'new' then return 'panel-warning'
      when 'open' then return 'panel-info'
      when 'closed' then return 'panel-success'
      else return ''
# Example:
#   items: ->
#

# TicketsShow: Lifecycle Hooks
Template.TicketsShow.created = ->

Template.TicketsShow.rendered = ->

Template.TicketsShow.destroyed = ->
