define ['server/game_world'], (GameWorld) ->

  describe 'server/GameWorld', ->

    it 'accepts physical objects', ->
      stub = sinon.stub()
      world = new GameWorld
      world.registerObject(stub)
      world.objects.length.should.equal 1

    it 'steps the objects at each timestep', ->
      obj = { step: -> true }
      mock = sinon.mock(obj).expects('step').withArgs(123).once()
      world = new GameWorld
      world.registerObject(obj)
      world.step(123)
      mock.verify().should.be.true

    it 'emits `stepped` at each timestep', ->

      spy = sinon.spy()

      world = new GameWorld
      world.on('stepped', spy)
      world.step(123)

      spy.called.should.be.true
      
