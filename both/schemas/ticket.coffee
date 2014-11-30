@Schemas ||= {}
Schemas.Ticket = new SimpleSchema
  uid:
    type: Number
    min: 1
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
  userId:
    type: String
  assigneeIds:
    type: [String]
    defaultValue: []
  createdAt:
    type: Date
  updatedAt:
    type: Date

Schemas.TicketUpdate = new SimpleSchema
  createdAt:
    type: Date
  ticketId:
    type: String
  ticketUid:
    type: String
  userId:
    type: String
  comment:
    type: String
    max: 1024
    optional: true
  fields:
    type: [Object]
    blackbox: true
    maxCount: 16
    defaultValue: []

Tickets.attachSchema Schemas.Ticket
