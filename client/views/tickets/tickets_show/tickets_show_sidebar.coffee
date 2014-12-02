Template.TicketsShowSidebar.events
  'click .setStatusNew':    -> Meteor.call 'ticketsSetStatus', @ticket()._id, 'new'
  'click .setStatusOpen':   -> Meteor.call 'ticketsSetStatus', @ticket()._id, 'open'
  'click .setStatusClosed': -> Meteor.call 'ticketsSetStatus', @ticket()._id, 'closed'

Template.TicketsShowSidebar.rendered = ->
  Template.TicketsShowSidebar.safariFix '#ticketSidebarNav'
  $('#ticketSidebarNav').affix
    offset:
      top: ->
        fix = $('#ticketSidebarNav').hasClass 'affix-top'
        if fix then 65 else 131

Template.TicketsShowSidebar.safariFix = (elemId) ->
  # Check if we are in safari
  return unless navigator.userAgent.indexOf('Safari') != -1
  return unless navigator.userAgent.indexOf('Chrome') == -1

  stickywidget = $(elemId)
  explicitlySetAffixPosition = ->
    stickywidget.css 'left', stickywidget.offset().left + 'px'

  # Before the element becomes affixed, add left CSS that is
  # equal to the distance of the element from the left of the screen
  stickywidget.on 'affix.bs.affix', -> explicitlySetAffixPosition()

  # On resize of window, un-affix affixed widget to measure where
  # it should be located, set the left CSS accordingly, re-affix it
  $(window).resize ->
    return unless stickywidget.hasClass 'affix'
    stickywidget.removeClass 'affix'
    explicitlySetAffixPosition()
    stickywidget.addClass 'affix'
