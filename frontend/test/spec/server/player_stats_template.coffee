define ['scripts/server/player_stats_template'], (Template) ->

  describe 'server/PlayerStatsTemplate', ->
    it 'should render the template to the el', ->
      $el = { html: -> true }
      mock = sinon.mock($el)
      mock.expects('html').withArgs("<div id='num_players'>1 player</div>")

      tmpl = new Template($el)
      tmpl.display({ num_players: "1 player" })
        
