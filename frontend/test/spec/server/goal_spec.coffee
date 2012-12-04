define ['server/goal'], (Goal) ->
  
  set = beforeEach

  describe 'server/Goal', ->

    describe '.buildGoalmouth()', ->
      set -> @rink = {world_object: { position: [250,250], radius: 250 }}
      set -> @goal = new Goal(rink: @rink, angle: 45, goalmouthAngle: 40)
      beforeEach ->
        @goalmouth = @goal.buildGoalmouth()

      it 'should be centered on the rink center', ->
        @goalmouth.position.should.eql [250,250]

      it 'should have the radius of the rink', ->
        @goalmouth.radius.should.equal 250

      it 'should have the current arcAngles', ->
        @goalmouth.arcAngles.should.eql [25,65]

    describe '.buildPlayerRink()', ->
      set -> @rink = {world_object: { position: [250,250], radius: 250 }}
      set -> @goal = new Goal(rink: @rink, angle: 0, goalmouthAngle: 40)

      beforeEach -> @playerRink = @goal.buildPlayerRink()

      it 'should be centered on the goal center', ->
        @playerRink.world_object.position.should.eql [500,250]

