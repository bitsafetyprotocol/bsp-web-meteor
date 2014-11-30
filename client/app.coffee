#
# Client App Namespace
#
_.extend App, {}

App.helpers =
  timeAgo: (time) ->
    ago = moment(time).fromNow()
    html = "<abbr title='#{time}'>#{ago}</abbr>"
    new Handlebars.SafeString html

_.each App.helpers, (helper, key) ->
  Handlebars.registerHelper key, helper
  return
