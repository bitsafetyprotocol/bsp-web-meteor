# Breadcrumbs: Event Handlers and Helpers
Template.Breadcrumbs.events
# Example:
#  "click .selector": (e, tmpl) ->
#

Template.Breadcrumbs.helpers
  sections: ->
    sections = []
    sections.push
      label: 'Home'
      route: 'Home'

    ctrl = Router.current()
    current = ctrl.route.getName()
    params  = ctrl.state.get('params') || {}

    if current.indexOf('tickets.') >= 0
      sections.push
        label: 'Tickets'
        route: 'tickets.index'
      switch current
        when 'tickets.new'
          sections.push
            label: 'New'
            route: current
        when 'tickets.show'
          sections.push
            label: "Ticket ##{params.uid}"
            route: current
            params: params

    sections[sections.length-1].active = true
    sections

# Breadcrumbs: Lifecycle Hooks
Template.Breadcrumbs.created = ->

Template.Breadcrumbs.rendered = ->

Template.Breadcrumbs.destroyed = ->
