@Tickets = new Mongo.Collection('tickets');
#Tickets.timestampable()
#
# Add query methods like this:
#  Tickets.findPublic = ->
#    Tickets.find is_public: true
#
