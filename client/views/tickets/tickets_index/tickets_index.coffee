# TicketsIndex: Event Handlers and Helpers
Template.TicketsIndex.events
# Example:
#  "click .selector": (e, tmpl) ->
#

Template.TicketsIndex.helpers
# Example:
#   items: ->
#

# TicketsIndex: Lifecycle Hooks
Template.TicketsIndex.created = ->

Template.TicketsIndex.rendered = ->

Template.TicketsIndex.destroyed = ->

Template.ticketRow.helpers
  rowClass: (status) ->
    switch status
      when 'new' then return 'warning'
      when 'closed' then return 'success'
      else return ''

  statusClass: (status) ->
    switch status
      when 'new' then return 'text-warning'
      when 'closed' then return 'text-success'
      else return ''

  iconClass: (status) ->
    switch status
      when 'new' then return 'fui-alert-circle'
      when 'open' then return 'fui-question-circle'
      when 'closed' then return 'fui-check'
      else return ''
Template.ticketRow.events
  'click button.delete': -> Meteor.call 'ticketsDelete', @_id
  'click button.closeTicket': -> Meteor.call 'ticketsClose', @_id

Template.TicketsIndexSearch.rendered = ->
  @$('.input-group').on 'focus', '.form-control', ->
    $(this).closest('.input-group, .form-group').addClass('focus')
  @$('.input-group').on 'blur', '.form-control', ->
    $(this).closest('.input-group, .form-group').removeClass('focus')

Template.TicketsIndexSearch.events
  'keyup input': (e, tpl) ->
    return unless e.keyCode == 13
    qs = tpl.$('input').val()
    console.log 'searching for', qs
  'click button': (e, tpl) ->
    qs = tpl.$('input').val()
    console.log 'searching for', qs
