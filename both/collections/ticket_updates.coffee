@TicketUpdates = new Meteor.Collection 'ticket_updates'

TicketUpdates.before.insert (userId, doc) ->
  doc.userId = userId
  doc.createdAt = new Date

TicketUpdates.helpers
  user: -> Users.findOne @userId
  userName: -> @user()?.getName() || 'Anonymous'
  ticket: -> Tickets.findOne @ticketId
