define ['server/collisions'], (Collisions) ->

  set = beforeEach

  describe 'server/Collisions.CircleWithAntiArc', ->
    before ->
      @subjectStart = (opts) ->
        @subject.position = opts.position if opts.position
        @subject.velocity = opts.velocity if opts.velocity
      @expectSubjectVelocitySetTo = (newV) -> @mock.expects('setVelocity').withArgs(newV)
      @expectSubjectMovedBy = (offsetP) -> @mock.expects('moveBy').withArgs(offsetP)

    set -> @subject = { position: [50,50], velocity: [10,0], getPosition: (-> @position), getRadius: (-> 11), getVelocity: (-> @velocity), setVelocity: (-> true), moveBy: (-> true) }
    set -> @antiArc = { getPosition: (-> [50,50]), getRadius: (-> 50), getVelocity: (-> [0,0]), getArcAngles: (-> [-45,45]) }

    set -> @collision = new Collisions.CircleWithAntiArc(@subject, @antiArc)
    set -> @mock = sinon.mock(@subject)

    afterEach -> @mock.verify().should.be.true

    describe 'doesCollide', ->
      describe 'within arc radius', ->
        it 'should not collide', ->
          @collision.doesCollide().should.be.false

      describe 'touching arc radius', ->
        describe 'within arc angles', ->
          it 'should collide if touching start of arc', ->
            @subjectStart position: [50+50/Math.sqrt(2),50+50/Math.sqrt(2)]
            @collision.doesCollide().should.be.true

          it 'should collide if touching within the arc', ->
            @subjectStart position: [90,55]
            @collision.doesCollide().should.be.true

          it 'should collide if touching end of arc', ->
            @subjectStart position: [50+50/Math.sqrt(2),50-50/Math.sqrt(2)]
            @collision.doesCollide().should.be.true

        describe 'outwith arc angles', ->
          it 'should not collide if touching radius but outwith the arc angle', ->
            @subjectStart position: [50,90]
            @collision.doesCollide().should.be.false

          it 'should not collide if touching radius but outwith the arc angle', ->
            @subjectStart position: [10,50]
            @collision.doesCollide().should.be.false

          it 'should not collide if touching radius but outwith the arc angle', ->
            @subjectStart position: [50,10]
            @collision.doesCollide().should.be.false

      describe 'subjectAngle', ->
        #center of arc is [50,50]
        it 'should be zero when horizontal', ->
          @subjectStart position: [100,50]
          @collision.subjectAngle().should.be.closeTo(0,0.0001)

        it 'should be 90 when straight down', ->
          @subjectStart position: [50,0]
          @collision.subjectAngle().should.be.closeTo(90,0.0001)

        it 'should be 180 when straight back', ->
          @subjectStart position: [0,50]
          @collision.subjectAngle().should.be.closeTo(180,0.0001)

        it 'should be 270 when straight up', ->
          @subjectStart position: [50,100]
          @collision.subjectAngle().should.be.closeTo(270,0.0001)
###
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

