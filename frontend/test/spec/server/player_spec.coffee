require ['server/player'], (Player) ->
  set = beforeEach

  describe 'server/Player', ->
    describe 'constructor', ->
      set -> @player = new Player(name: 'Pete')

      it 'should have a name', ->
        @player.name.should.equal 'Pete'

    describe 'delegation', ->
      set -> @player = new Player()
      it 'should be moveToAble', ->
        @player.moveTo([5,10])
        @player.getPosition().should.eql [5,10]

      it 'should be moveByAble', ->
        @player.moveTo([10,5])
        @player.moveBy([1,-1])
        @player.getPosition().should.eql [11,4]

      #it 'should have a graphic', ->
      #  player = new Player()
      #  player.world_object.should.not.be.undefined
