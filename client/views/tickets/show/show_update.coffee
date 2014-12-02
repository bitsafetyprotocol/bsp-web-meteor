Template.TicketShowUpdate.events
  'click .close': -> Meteor.call 'ticketsDeleteUpdate', @_id
