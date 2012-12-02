define ['server/collisions'], (Collisions) ->


  describe 'server/Collisions.CircleWithAntiCircle', ->
    describe 'deal with velocity', ->
      before ->
        @subjectStart = (opts) ->
          @subject.position = opts.position if opts.position
          @subject.velocity = opts.velocity if opts.velocity
        @expectSubjectVelocitySetTo = (newV) -> @mock.expects('setVelocity').withArgs(newV)

      beforeEach ->
        @subject = { position: [50,50], radius: 10, velocity: [10,0], setVelocity: (-> true), moveBy: (-> true) }
        @antiCircle = { position: [50,50], radius: 50, velocity: [0,0] }
        @collision = new Collisions.CircleWithAntiCircle(@subject, @antiCircle)
        @mock = sinon.mock(@subject)

      afterEach ->
        @mock.verify().should.be.true


      describe 'simple collisions', ->
        afterEach ->
          @collision.collide()

        it 'does nothing if they dont collide', ->
          @mock.expects('setVelocity').never()

        it 'reverses x direction if they collide horizontally', ->
          @subjectStart position: [90,50]
          @expectSubjectVelocitySetTo [-10,0]

        it 'reverses y direction if they collide vertically', ->
          @subjectStart position: [50,90], velocity: [0,10]
          @expectSubjectVelocitySetTo [0,-10]
      
      describe 'complicated collision', ->
        beforeEach -> sinon.spy(@subject, 'setVelocity')
        afterEach -> @subject.setVelocity.restore()

        it 'flips direction if collide at 45 degrees', ->
          @subjectStart position: [ (50 + 50/Math.sqrt(2)), (50 + 50/Math.sqrt(2)) ], velocity: [10,0]

          @collision.collide()

          newVelocity = @subject.setVelocity.getCall(0).args[0]
          newVelocity[0].should.be.closeTo(0, 0.0001)
          newVelocity[1].should.be.closeTo(-10, 0.0001)


    #describe 'deal with position', ->
    #  it 'doesnt change the position if they are not colliding', ->
    #    @mock.expects('moveBy').never()
    #    @collision.collide()

    #  it 'adjusts if partially overlapping horizontally', ->
    #    @subject.position = [90,50]
    #    @mock = sinon.mock(@subject)
    #    @mock.expects('setVelocity').withArgs([-10,0])
    #    @collision.collide()
