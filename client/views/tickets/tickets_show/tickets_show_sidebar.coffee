Template.TicketsShowSidebar.events
  'click .setStatusNew':    -> Meteor.call 'ticketsSetStatus', @ticket()._id, 'new'
  'click .setStatusOpen':   -> Meteor.call 'ticketsSetStatus', @ticket()._id, 'open'
  'click .setStatusClosed': -> Meteor.call 'ticketsSetStatus', @ticket()._id, 'closed'
