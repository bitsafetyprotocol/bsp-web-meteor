# Navbar: Event Handlers and Helpers
Template.Navbar.events
  'click #logout': -> Meteor.logout()
# Example:
#  "click .selector": (e, tmpl) ->
#

Template.Navbar.helpers
# Example:
#   items: ->
#

# Navbar: Lifecycle Hooks
Template.Navbar.created = ->

Template.Navbar.rendered = ->
  @$('.dropdown').dropdown
    on: 'hover'

Template.Navbar.destroyed = ->
