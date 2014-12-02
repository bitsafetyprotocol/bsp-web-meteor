@Schema ||= {}

Schema.Ticket = new SimpleSchema
  uid:
    type: Number
    min: 1
    optional: true
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
    optional: true
  createdAt:
    type: Date
    optional: true
  updatedAt:
    type: Date
    optional: true

Tickets.attachSchema Schema.Ticket
