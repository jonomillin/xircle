define ['server/collisions'], (Collisions) ->

  set = beforeEach

  describe 'server/Collisions.CircleWithAntiCircle', ->
    before ->
      @subjectStart = (opts) ->
        @subject.position = opts.position if opts.position
        @subject.velocity = opts.velocity if opts.velocity
      @expectSubjectVelocitySetTo = (newV) -> @mock.expects('setVelocity').withArgs(newV)
      @expectSubjectMovedBy = (offsetP) -> @mock.expects('moveBy').withArgs(offsetP)

    set -> @subject = { position: [50,50], radius: 10, velocity: [10,0], setVelocity: (-> true), moveBy: (-> true) }
    set -> @antiCircle = { position: [50,50], radius: 50, velocity: [0,0] }
    set -> @collision = new Collisions.CircleWithAntiCircle(@subject, @antiCircle)
    set -> @mock = sinon.mock(@subject)

    afterEach -> @mock.verify().should.be.true

    describe 'deal with velocity', ->
      describe 'simple collisions', ->
        afterEach -> @collision.collide()

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

    describe 'fixes overlaps', ->
      describe 'simple overlaps', ->
        afterEach -> @collision.collide()

        it 'doesnt change the position if they are not overlapping', ->
          @mock.expects('moveBy').never()

        it 'adjusts if partially overlapping horizontally', ->
          @subjectStart position: [91,50]
          @expectSubjectMovedBy [-1, 0]

        it 'adjusts if completely overlapping horizontally', ->
          @subjectStart position: [120,50]
          @expectSubjectMovedBy [-30, 0]

        it 'adjusts if partially overlapping vertically', ->
          @subjectStart position: [50,91]
          @expectSubjectMovedBy [0, -1]

        it 'adjusts if completely overlapping horizontally', ->
          @subjectStart position: [50,120]
          @expectSubjectMovedBy [0, -30]

