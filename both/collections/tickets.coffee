@Tickets = new Meteor.Collection 'tickets'
Tickets.helpers
  author: -> Users.findOne @authorId
  assignees: -> Users.find {_id: {$in: @assigneeIds}}

Tickets.before.update (userId, doc, fields, mod) ->
  console.log "updating ticket ##{doc.uid}"
  changes = {}

  for fieldName, newValue of mod.$set
    continue if fieldName is 'updatedAt'
    oldValue = doc[fieldName]
    continue if newValue is oldValue
    changes[fieldName] = { before: oldValue, after: newValue }

  return if _.isEmpty changes

  TicketUpdates.insert { fields: changes }
  console.log changes

@TicketUpdates = new Meteor.Collection 'ticketUpdates'
TicketUpdates.helpers
  user: -> Users.findOne @
