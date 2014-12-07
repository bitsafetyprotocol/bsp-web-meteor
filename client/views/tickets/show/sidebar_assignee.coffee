Template.TicketSidebarAssignee.rendered = ->
  select = @$('input.select2').select2
    placeholder: 'None'
    multiple: true
    minimumInputLength: 2
    query: (options) ->
      App.subsManager.subscribe 'tickets_user_query', options.term, ->
        users = Users.queryEmails(options.term).fetch()
        options.callback
          results: _.map users, (user) -> { id: user._id, text: user.getName() }
          more: false

    initSelection: (element, callback) ->
      callback []

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
