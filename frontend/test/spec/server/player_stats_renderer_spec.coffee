define ['server/player_stats_renderer', 'shared/micro_event'], (PlayerStatsRenderer, Event) ->

  describe 'server/PlayerStatsRenderer', ->
    it 'should render the player count', ->
      manager = new Event
      target = { display: -> }
      mock = sinon.mock(target)
        
      mock.expects('display').withArgs({player_count: '1 players'})

      new PlayerStatsRenderer(player_manager: manager, output: target)

      manager.emit('player:registered', {}, 1)
      
      expect(mock.verify()).to.be.true

