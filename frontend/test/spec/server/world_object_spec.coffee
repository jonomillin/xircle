define ['server/world_object'], (WorldObject) ->
  
  describe 'server/WorldObject', ->
    it 'has a position', ->
      new WorldObject(position: [1,2]).position.should.eql [1,2]

    it 'has a velocity', ->
      new WorldObject(velocity: [2,1]).velocity.should.eql [2,1]

    it 'has a radius', ->
      new WorldObject(radius: 5).radius.should.equal 5

    it "updates it's position by it's velocity on a timestep", ->
      obj = new WorldObject( velocity: [10,-20], position: [5,10] )
      obj.step(0.1)
      obj.position.should.eql [6,8]

    it 'can by movedBy', ->
      obj = new WorldObject( position: [5,10] )
      obj.moveBy( [1,-1] )
      obj.position.should.eql [6,9]

    it 'can be movedTo', ->
      obj = new WorldObject( position: [5,10] )
      obj.moveTo( [20,30] )
      obj.position.should.eql [20,30]
      
    it 'can have it\'s velocity set', ->
      obj = new WorldObject( position: [5,10] )
      obj.setVelocity( [10, -10] )
      obj.velocity.should.eql [10,-10]

