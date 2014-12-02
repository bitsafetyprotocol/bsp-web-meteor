@TicketUsers = new Meteor.Collection 'ticket_users'

TicketUsers.before.insert (userId, doc) ->
  doc.createdAt = new Date
