Template.TicketsShow.events {}

Template.TicketsShow.helpers
  infoPanelClass: (status) ->
    switch status
      when 'new' then return 'panel-warning'
      when 'open' then return 'panel-info'
      when 'closed' then return 'panel-success'
      else return ''

Template.TicketsShow.created = ->

Template.TicketsShow.rendered = ->

Template.TicketsShow.destroyed = ->


Template.TicketShowCommentForm.events
  'click .postComment': (e, tpl) ->
    id = @ticket()._id
    comment = tpl.$('textarea').val()
    console.log id, comment
    Meteor.call 'ticketsPostComment', id, comment

Template.TicketUpdatesPartial.events
  'click .close': (e, tpl)-> Meteor.call 'ticketsDeleteUpdate', @_id
