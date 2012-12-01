require ['server/player'], (Player) ->

  describe 'server/Player', ->
    describe 'constructor', ->
      it 'should have a name', ->
        player = new Player(name: 'Pete')
        expect(player.name).to.equal 'Pete'

      it 'should be moveToAble', ->
        player = new Player()
        player.moveTo([5,10])
        player.world_object.position.should.eql [5,10]

      it 'should be moveByAble', ->
        player = new Player()
        player.moveTo([10,5])
        player.moveBy([1,-1])
        player.world_object.position.should.eql [11,4]

      #it 'should have a graphic', ->
      #  player = new Player()
      #  player.world_object.should.not.be.undefined
