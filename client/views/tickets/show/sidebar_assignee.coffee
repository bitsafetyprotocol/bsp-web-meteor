Template.TicketSidebarAssignee.rendered = ->
  select = @$('select').select2
    placeholder: 'None'

  Deps.autorun =>
    items = TicketUsers.find { ticketId: @data.ticket._id }, { fields: { userId: 1 } }
    userIds = _.map items.fetch(), (item) -> item.userId
    select.select2 'val', userIds

Template.TicketSidebarAssignee.helpers
  users: -> Users.find {}, { sort: { 'emails.$.address': 1 } }

Template.TicketSidebarAssignee.events
  'change select': (e, tpl) ->
    ticket = tpl.data.ticket
    if e.added
      Meteor.call 'ticketsUserAdd', ticket._id, e.added.id
    else if e.removed
      Meteor.call 'ticketsUserRemove', ticket._id, e.removed.id
