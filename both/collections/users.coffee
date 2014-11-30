@Users = Meteor.users
Users.helpers
  email: -> @emails[0].address
