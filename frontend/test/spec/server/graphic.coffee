define ['server/graphic', 'easel'], (Graphic, easel) ->
  Graphics = easel.Graphics

  describe 'server/Graphic', ->
    it 'should render to the stage', ->
      shape = { x: 0, y: 0 }
      stage = { addChild: (thing) -> true}

      mock = sinon.mock(stage).expects('addChild').withArgs(shape)
      
      circle = new Graphic(shape: shape)
      circle.renderTo(stage, [5, 10])

      mock.verify().should.be.true
      
      
