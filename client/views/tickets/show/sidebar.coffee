Template.TicketSidebar.events
  'click .setStatusNew':    -> Meteor.call 'ticketsSetStatus', @ticket._id, 'new'
  'click .setStatusOpen':   -> Meteor.call 'ticketsSetStatus', @ticket._id, 'open'
  'click .setStatusClosed': -> Meteor.call 'ticketsSetStatus', @ticket._id, 'closed'

Template.TicketSidebar.rendered = ->
  Template.TicketSidebar.safariFix '#ticketSidebarNav'

  baseOffset = $('#ticketSidebar').offset().top
  stickyOffset = $('.breadcrumb').outerHeight(true)

  $('#ticketSidebar').affix
    offset:
      top: ->
        sticky = $('#ticketSidebar').hasClass 'affix'
        if sticky then baseOffset else stickyOffset

Template.TicketSidebar.safariFix = (elemId) ->
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
