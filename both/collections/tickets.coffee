@Tickets = new Meteor.Collection 'tickets'

Tickets.before.insert (userId, doc) ->
  doc.userId = userId
  doc.createdAt = new Date
  doc.updatedAt = doc.createdAt

  last = Tickets.findOne({}, {sort: {uid: -1}, fields: {uid: 1}})?.uid || 0
  doc.uid = last + 1

Tickets.before.update (userId, doc, fields, mod) ->
  console.log "updating ticket ##{doc.uid}"
  changes = []

  for fieldName, newValue of mod.$set
    continue if fieldName is 'updatedAt'
    oldValue = doc[fieldName]
    continue if newValue is oldValue
    changes.push
      name: fieldName
      before: oldValue
      after: newValue

  return if _.isEmpty changes

  TicketUpdates.insert
    ticketId: doc._id
    ticketUid: doc.uid
    fields: changes

  mod.$set.updatedAt = new Date
  console.log changes

Tickets.createStub = ->
  rnd = Math.floor(Math.random() * 100500)
  Tickets.insert
    subject: "ticket #{rnd}"
    description: "some very long description here"

Tickets.helpers
  user: -> Users.findOne @userId
  userName: -> @user()?.getName() || 'Anonymous'
  assignees: -> Users.find _id: { $in: @assigneeIds }
  updates: -> TicketUpdates.find { ticketId: @_id }, { sort: { createdAt: 1 } }

@TicketUpdates = new Meteor.Collection 'ticket_updates'

TicketUpdates.before.insert (userId, doc) ->
  doc.userId = userId
  doc.createdAt = new Date

TicketUpdates.helpers
  user: -> Users.findOne @userId
  userName: -> @user()?.getName() || 'Anonymous'
  ticket: -> Tickets.findOne @ticketId

