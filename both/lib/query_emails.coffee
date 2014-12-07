Meteor.users.queryEmails = (query) ->
  selector =
    emails:
      $elemMatch:
        address: $regex: new RegExp "^#{query}"

  options =
    limit: 10
    sort:   { 'emails.$.address': 1 }
    fields: { emails: 1 }

  Users.find selector, options

