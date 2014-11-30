#
# Tickets Methods
#

Meteor.methods
  ticketsDelete: (id) -> Tickets.remove id
  ticketsSetStatus: (id, status) -> Tickets.update id, $set: { status: status }
  ticketsClose: (id) -> Meteor.call 'ticketsSetStatus', id, 'closed'

#
#   Example:
#    '/app/tickets/update/email': function (email) {
#      Users.update({_id: this.userId}, {$set: {'profile.email': email}});
#    }
#
#
