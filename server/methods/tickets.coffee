Meteor.methods
  ticketsDelete: (id) -> Tickets.remove id
  ticketsDeleteUpdate: (id) -> TicketUpdates.remove id
  ticketsSetStatus: (id, status) -> Tickets.update id, $set: { status: status }
  ticketsClose: (id) -> Meteor.call 'ticketsSetStatus', id, 'closed'
  ticketsPostComment: (id, comment) ->
    TicketUpdates.insert
      ticketId: id
      comment: comment
  ticketsInsert: (doc) ->
    id = Tickets.insert doc
    Tickets.findOne id

  ticketsUserAdd: (ticketId, userId) ->
    selector =
      ticketId: ticketId
      userId: userId

    unless Tickets.findOne(ticketId, fields: { _id: 1 })
      throw new Meteor.Error 'ticket not found'
    unless Users.findOne(userId, fields: { _id: 1 })
      throw new Meteor.Error 'user not found'
    if TicketUsers.findOne(selector, fields: { _id: 1 })
      throw new Meteor.Error 'existing record'

    TicketUsers.insert selector

  ticketsUserRemove: (ticketId, userId) ->
    TicketUsers.remove ticketId: ticketId, userId: userId
