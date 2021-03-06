@Tickets = new Meteor.Collection 'tickets'

Tickets.before.insert (userId, doc) ->
  doc.userId = userId
  doc.createdAt = new Date
  doc.updatedAt = doc.createdAt

  last = Tickets.findOne({}, {sort: {uid: -1}, fields: {uid: 1}})?.uid || 0
  doc.uid = last + 1

Tickets.before.update (userId, doc, fields, mod) ->
  mod.$set.updatedAt = new Date
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

Tickets.helpers
  user: -> Users.findOne @userId
  userName: -> @user()?.getName() || 'Anonymous'
  assignees: -> Users.find _id: { $in: @assigneeIds }
  updates: -> TicketUpdates.find { ticketId: @_id }, { sort: { createdAt: 1 } }
