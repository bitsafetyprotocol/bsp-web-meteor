@Schema ||= {}

Schema.TicketUser = new SimpleSchema
  userId:
    type: String
  ticketId:
    type: String
  createdAt:
    type: Date
    optional: true

TicketUsers.attachSchema Schema.TicketUser
