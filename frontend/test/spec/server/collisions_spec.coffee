define ['server/collisions'], (Collisions) ->

  describe 'server/Collisions.CircleWithAntiCircle', ->
    describe 'deal with velocity', ->
      before ->
        @subject = { position: [50,50], radius: 10, velocity: [10,0], setVelocity: -> true, moveBy: -> true }
        @antiCircle = { position: [50,50], radius: 50, velocity: [0,0] }
        @collision = new Collisions.CircleWithAntiCircle(@subject, @antiCircle)

      it 'does nothing if they dont collide', ->
        mock = sinon.mock(@subject)
        mock.expects('setVelocity').never()
        @collision.collide()
        mock.verify().should.be.true

      it 'reverses x direction if they collide horizontally', ->
        @subject.position = [90,50]
        mock = sinon.mock(@subject)
        mock.expects('setVelocity').withArgs([-10,0])
        @collision.collide()
        mock.verify().should.be.true

      it 'reverses y direction if they collide vertically', ->
        @subject.position = [50,90]
        @subject.velocity = [0,10]
        mock = sinon.mock(@subject)
        mock.expects('setVelocity').withArgs([0,-10])
        @collision.collide()
        mock.verify().should.be.true
      
      it 'sorts flips direction if collide at 45 degrees', ->
        sinon.spy(@subject, 'setVelocity')
        @subject.position = [ (50 + 50/Math.sqrt(2)), (50 + 50/Math.sqrt(2)) ]
        @subject.velocity = [10,0]
        @collision.collide()

        @subject.setVelocity.calledOnce.should.be.true
        newVelocity = @subject.setVelocity.getCall(0).args[0]
        newVelocity[0].should.be.within(-0.00001, 0.00001)
        newVelocity[1].should.be.within(-10.00001, -9.9999)

        @subject.setVelocity.restore()

    describe 'deal with position', ->
      it 'doesnt change the position if they are not colliding', ->
        mock = sinon.mock(@subject)
        mock.expects('moveBy').never()
        @collision.collide()
        mock.verify().should.be.true

      it 'adjusts if partially overlapping horizontally', ->
        @subject.position = [90,50]
        mock = sinon.mock(@subject)
        mock.expects('setVelocity').withArgs([-10,0])
        @collision.collide()
        mock.verify().should.be.true
