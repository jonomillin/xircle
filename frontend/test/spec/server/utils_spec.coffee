define ['server/utils'], (Utils) ->
  describe 'server/Utils', ->
    describe 'degreesToRadians', ->
      it 'should convert 0', ->
        Utils.degreesToRadians(0).should.equal 0

      it 'should convert 90', ->
        Utils.degreesToRadians(90).should.be.closeTo Math.PI/2, 0.001

      it 'should convert 180', ->
        Utils.degreesToRadians(180).should.be.closeTo Math.PI, 0.001

      it 'should convert 270', ->
        Utils.degreesToRadians(270).should.be.closeTo (3/2)*Math.PI, 0.001

      it 'should convert 360', ->
        Utils.degreesToRadians(360).should.be.closeTo 2*Math.PI, 0.001

    describe 'radiansToDegress', ->
      it 'should convert 0', ->
        Utils.radiansToDegrees(0).should.equal 0

      it 'should convert 90', ->
        Utils.radiansToDegrees(Math.PI/2).should.be.closeTo 90, 0.001

      it 'should convert 180', ->
        Utils.radiansToDegrees(Math.PI).should.be.closeTo 180, 0.001

      it 'should convert 270', ->
        Utils.radiansToDegrees((3/2)*Math.PI).should.be.closeTo 270, 0.001

      it 'should convert 360', ->
        Utils.radiansToDegrees(2*Math.PI).should.be.closeTo 360, 0.001

    describe 'angleInRange', ->
      it 'should be true if in range', ->
        Utils.angleInRange(10, [0,10]).should.be.true
      it 'should be false if not in range', ->
        Utils.angleInRange(40, [0,10]).should.be.false
      it 'should be true if in a wrapped range (negatives)', ->
        Utils.angleInRange(5, [-10,10]).should.be.true
        Utils.angleInRange(-5, [-10,10]).should.be.true

      it 'should be true if in a wrapped range (negatives)', ->
        Utils.angleInRange(5, [-10,10]).should.be.true
        Utils.angleInRange(-5, [-10,10]).should.be.true
        Utils.angleInRange(355, [-10,10]).should.be.true

      it 'should be true if in a wrapped range (positives)', ->
        Utils.angleInRange(5, [350,10]).should.be.true
        

