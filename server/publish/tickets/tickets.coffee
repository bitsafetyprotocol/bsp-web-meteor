#
# TicketsIndex Publish Functions
#
Meteor.publish "tickets_index", ->
  Tickets.find({}, {sort: {uid: -1}})

Meteor.publish "tickets_show", (uid) ->
  Tickets.find
    uid: parseInt(uid)

