define ['server/goal'], (Goal) ->
  
  set = beforeEach

  describe 'server/Goal', ->

    describe '.buildGoalmouth()', ->
      set -> @rink = {world_object: { position: [250,250], radius: 250 }}
      set -> @goal = new Goal(rink: @rink, angle: 45, goalmouthAngle: 40)
      set -> @goalmouth = @goal.parts.goalMouth

      it 'should be centered on the rink center', ->
        @goalmouth.getPosition().should.eql [250,250]

      it 'should have the radius of the rink', ->
        @goalmouth.getRadius().should.equal 250

      it 'should have the current arcAngles', ->
        @goalmouth.getArcAngles().should.eql [25,65]

    describe '.buildPlayerRink()', ->
      set -> @rink = {world_object: { position: [250,250], radius: 250 }}
      set -> @goal = new Goal(rink: @rink, angle: 0, goalmouthAngle: 40)

      set -> @playerRink = @goal.parts.playerRink

      it 'should be centered on the goal center', ->
        @playerRink.getPosition().should.eql [500,250]

