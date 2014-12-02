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
        ids = ticket.assigneeIds || []
        ids.push ticket.userId
        Users.find _id: { $in: ids }
    }
    {
      find: (ticket) ->
        TicketUpdates.find(ticketId: ticket._id)
      children: [
        find: (ticketUpdate) ->
          Users.find ticketUpdate.userId
      ]
    }
  ]

Meteor.publish "ticket_updates", ->
  TicketUpdates.find()

