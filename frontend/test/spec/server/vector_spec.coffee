define ['server/vector'], (Vector) ->
  describe 'server/Vector', ->
    describe 'angleDeg', ->
      it 'should be 0 when horizontal', ->
        Vector.angleDeg([10,0]).should.be.closeTo 0, 0.001
      it 'should be 90 when straight down', ->
        Vector.angleDeg([0,-10]).should.be.closeTo 90, 0.001
      it 'should be 180 when straight back', ->
        Vector.angleDeg([-10,0]).should.be.closeTo 180, 0.001
      it 'should be 270 when straight up', ->
        Vector.angleDeg([0,10]).should.be.closeTo 270, 0.001
    describe 'rotateRad', ->
      it 'should rotate 90', ->
        result = Vector.rotateRad([10,0],Math.PI/2)
        result[0].should.be.closeTo 0, 0.001
        result[1].should.be.closeTo -10, 0.001

