# Client and Server Routes

Router.configure
  layoutTemplate: "MasterLayout"
  loadingTemplate: "Loading"
  notFoundTemplate: "NotFound"

Router.route "/",
  name: "Home"

Router.route "/tickets",
  name: "tickets.index"
  waitOn: -> App.subsManager.subscribe 'tickets_index'
  data:
    tickets: -> Tickets.find({}, sort: { updatedAt: -1, uid: -1 })

Router.route "/tickets/new",
  name: "tickets.new"

Router.route "/tickets/:uid",
  name: "tickets.show"
  waitOn: ->
    [
      App.subsManager.subscribe 'tickets_show', @params.uid
      App.subsManager.subscribe 'ticket_users', @params.uid
    ]
  data: ->
    return unless ticket = Tickets.findOne { uid: parseInt(@params.uid) }

    ticket: ticket
    author: Users.findOne(ticket.authorId)
  action: ->
    @state.set 'params', _.extend {}, @params
    @render()

Router.onBeforeAction AccountsTemplates.ensureSignedIn,
  except: ['Home', 'atSignIn', 'atSignUp']
