#
# TicketsIndex Publish Functions
#
Meteor.publish "tickets_index", ->
  Tickets.find({}, {sort: {uid: -1}})

Meteor.publishComposite 'tickets_show', (uid) ->
  find: ->
    id = Tickets.findOne({ uid: parseInt(uid) }, { fields: { _id: 1 } })?._id
    Tickets.find(id)
  children: [
    {
      find: (ticket) ->
        TicketUpdates.find(ticketId: ticket._id)
      children: [
        find: (ticketUpdate) ->
          Users.find ticketUpdate.userId
      ]
    }
  ]

Meteor.publishComposite 'ticket_users', (uid) ->
  find: (ticket) ->
    id = Tickets.findOne({ uid: parseInt(uid) }, { fields: { _id: 1 } })?._id
    TicketUsers.find { ticketId: id }
  children: [
    find: (ticketUser) ->
      Users.find ticketUser.userId
  ]
