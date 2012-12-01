define ['server/shapes'], (Shapes) ->

  describe 'server/Shapes', ->

    describe 'Circle', ->
      it 'should be drawable', ->
        Shapes.Circle.draw({}).should.not.be.undefined
      
