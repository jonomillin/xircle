define ['server/game_world_renderer', 'jquery'], (GameWorldRenderer, $) ->

  describe 'server/GameWorldRenderer', ->
    it 'should be initialized with an element', ->
      stage = {}

      renderer = new GameWorldRenderer(stage: stage, width: 400, height: 500)
      renderer.height.should.equal 500
      renderer.width.should.equal 400


    it 'should render all the objects in the world onto it', ->
      stage = 'stage'
      obj = { renderTo: (stage) -> true }
      world = { objects: [obj], eachObject: (cb) -> @objects.forEach(cb) }

      mock = sinon.mock(obj).expects('renderTo').withArgs(stage)
      new GameWorldRenderer(stage: stage).render(world)
      mock.verify().should.be.true

      
