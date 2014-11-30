@Users = Meteor.users

Users.helpers
  email: -> @emails[0].address

  ticketsOwn: -> Tickets.find userId: @_id
  ticketsAssigned: -> Tickets.find assigneeIds: { $elemMatch: @_id }

  getName: ->
    return @profile.name if @profile?.name?

    if @profile?.firstName and @profile?.lastName
      return "#{@profile.firstName} #{@profile.lastName}"

    if @profile?.twitter
      return "<a href=\"http://twitter.com/#{@profile.twitter}\">#{@profile.twitter}</a>"

    return @username if @username

    return @emails[0].address if @emails[0]

    'Anonymous'

