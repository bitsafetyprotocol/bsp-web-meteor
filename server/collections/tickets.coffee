#
# Add query methods like this:
#  Tickets.findPublic = ->
#    Tickets.find is_public: true
#
Tickets.allow
  insert: (userId, doc) ->
    true

  update: (userId, doc, fieldNames, modifier) ->
    true

  remove: (userId, doc) ->
    true

Tickets.deny
  insert: (userId, doc) ->
    false

  update: (userId, doc, fieldNames, modifier) ->
    false

  remove: (userId, doc) ->
    false