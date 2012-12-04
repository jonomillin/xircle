define ['mixins/acts_as_object_group'], (ActsAsObjectGroup) ->
  class GameWorld

  ActsAsObjectGroup.mixin(GameWorld)

  describe 'server/ActsAsObjectGroup', ->

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
    
    describe 'collisions', ->
      it 'should register collisions', ->
        collision = {id: 1}
        world = new GameWorld
        world.registerCollision( collision )
        world.collisions[0].should.equal collision

      it 'runs the collisions at each timestep', ->
        collision = { collide: -> true }
        mock = sinon.mock(collision).expects('collide')
        world = new GameWorld
        world.registerCollision(collision)
        world.step(123)
        mock.verify().should.be.true
