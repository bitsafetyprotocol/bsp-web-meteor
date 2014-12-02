@Schema ||= {}

Schema.TicketUpdate = new SimpleSchema
  createdAt:
    type: Date
    optional: true
  ticketId:
    type: String
  ticketUid:
    type: String
  userId:
    type: String
    optional: true
  comment:
    type: String
    max: 1024
    optional: true
  fields:
    type: [Object]
    blackbox: true
    maxCount: 16
    defaultValue: []

TicketUpdates.attachSchema Schema.TicketUpdate
