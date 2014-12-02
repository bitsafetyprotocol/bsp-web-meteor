Template.TicketsShow.helpers
  infoPanelClass: (status) ->
    switch status
      when 'new' then return 'panel-warning'
      when 'open' then return 'panel-info'
      when 'closed' then return 'panel-success'
      else return ''
