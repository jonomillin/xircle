define ['underscore'], (_) ->
  window.tmpl = _.template("""<div id='num_players'><%= player_count %></div>""")

  class PlayerStatsTemplate
    constructor: ($el) ->
      @$el = $el
      @displayAttributes = {}
      
    render: ->
      h = tmpl(@displayAttributes)
      @$el.html h

    display: (new_attributes) ->
      @mergeDisplayAttributes(new_attributes)
      @render()

    mergeDisplayAttributes: (attrs) ->
      @displayAttributes ||= {}
      @displayAttributes = _.extend(@displayAttributes, attrs)
