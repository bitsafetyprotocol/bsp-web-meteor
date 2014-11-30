@Schemas ||= {}
Schemas.Ticket = new SimpleSchema
  uid:
    type: Number
    min: 1
    autoValue: ->
      return unless @isInsert
      last = Tickets.findOne({}, {sort: {uid: -1}, fields: {uid: 1}})?.uid || 0
      last + 1
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
    autoValue: -> @userId if @isInsert
#    optional: true
  assigneeIds:
    type: [String]
    defaultValue: []
  createdAt:
    type: Date
    autoValue: -> new Date if @isInsert
  updatedAt:
    type: Date
    autoValue: -> new Date

Schemas.TicketUpdate = new SimpleSchema
  createdAt:
    type: Date
    autoValue: -> new Date if @isInsert
  ticketId:
    type: String
  userId:
    type: String
    autoValue: -> @userId if @isInsert
  comment:
    type: String
    max: 1024
    optional: true
  fields:
    type: [Object]
    blackbox: true
    minCount: 1
    maxCount: 16

Tickets.attachSchema Schemas.Ticket
