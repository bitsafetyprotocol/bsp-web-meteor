@Schemas ||= {}
Schemas.Ticket = new SimpleSchema
  uid:
    type: Number
    min: 1
    autoValue: ->
      return @value if @isSet
      last = Tickets.findOne({}, {sort: {uid: -1}, fields: {uid: 1}})?.uid || 0
      return last + 1
  subject:
    type: String
    max: 200
  description:
    type: String
    min: 3
  status:
    type: String
    defaultValue: 'new'
    allowedValues: ['new', 'open', 'closed']
  authorId:
    type: String
    autoValue: ->
      return @value if @isSet
      @userId
    optional: true
  assigneeIds:
    type: [String]
    optional: true
  lastUpdate:
    type: Date
    autoValue: -> new Date

Tickets.attachSchema Schemas.Ticket
