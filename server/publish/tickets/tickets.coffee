#
# TicketsIndex Publish Functions
#
Meteor.publish "tickets_index", ->
  Tickets.find({}, {sort: {uid: -1}})

Meteor.publish "tickets_show", (uid) ->
  id = Tickets.findOne(uid: parseInt(uid))?._id
  [
    Tickets.find { uid: parseInt(uid) }
    TicketUpdates.find { ticketId: id }
  ]

Meteor.publish "ticket_updates", ->
  TicketUpdates.find()

