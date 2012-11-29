require ['scripts/server/player'], (Player) ->

  describe 'server/Player', ->
    describe 'constructor', ->
      it 'should have a name', ->
        player = new Player(name: 'Pete')
        expect(player.name).to.equal 'Pete'
