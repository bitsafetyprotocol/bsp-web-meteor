#
# Tickets Methods
#

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

#
#   Example:
#    '/app/tickets/update/email': function (email) {
#      Users.update({_id: this.userId}, {$set: {'profile.email': email}});
#    }
#
#
