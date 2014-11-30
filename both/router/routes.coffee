# Client and Server Routes

Router.configure
  layoutTemplate: "MasterLayout"
  loadingTemplate: "Loading"
  notFoundTemplate: "NotFound"

Router.route "/",
  name: "Home"

Router.route "/tickets",
  name: "tickets.index"
  waitOn: ->
    Meteor.subscribe('tickets_index')
  data:
    tickets: -> Tickets.find()

Router.route "/tickets/new",
  name: "tickets.new"

Router.route "/tickets/:uid",
  name: "tickets.show"
  waitOn: ->
    Meteor.subscribe('tickets_show', @params.uid)
  data:
    ticket: -> Tickets.findOne()

Router.onBeforeAction AccountsTemplates.ensureSignedIn,
  except: ['Home']
