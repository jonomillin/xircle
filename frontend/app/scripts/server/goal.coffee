define ['jquery', 'server/utils', 'mixins/acts_as_object_group', 'server/arc_object', 'server/rink', 'server/collisions', 'server/shapes'], ($,Utils, ActsAsObjectGroup, ArcObject, Rink, Collisions, Shapes) ->
  class PlayerRink extends Rink

  class Goal
    constructor: (options = {}) ->
      @rink = options.rink
      @angle = options.angle
      @goalmouthAngle = options.goalmouthAngle

      @parts = {}
      @player = options.player
      @buildGoal()

    setupBallCollisions: (ball) ->
      @registerCollision new Collisions.CircleWithAntiArc ball, @parts.goalMouth, ->
        ball.moveTo [250,250]
        $('body').append('score')
        
      @registerCollision new Collisions.CircleWithCircle(ball, @player)

    setupPlayerCollisions:  ->
      @registerCollision new Collisions.CircleWithAntiCircle(@player, @parts.playerRink)
      @registerCollision new Collisions.CircleWithAntiCircle(@player, @rink)

    buildGoal: ->
      @buildGoalmouth()
      @buildPlayerRink()
      @setupPlayerCollisions()

    buildGoalmouth: ->
      @parts.goalMouth = new ArcObject
        radius: @rinkRadius()
        position: @rinkCenter()
        arcAngles: [@angle - @goalmouthAngle/2, @angle + @goalmouthAngle/2]
        color: [255,0,0]
      @registerObject @parts.goalMouth

    buildPlayerRink: ->
      @parts.playerRink = new Rink
        shape: Shapes.CircleWater
        position: @calculatePlayerRinkCenter()
        radius: 100
      @registerObject @parts.playerRink

    rinkCenter: -> @rink.world_object.position
    rinkRadius: -> @rink.world_object.radius

    calculatePlayerRinkCenter: ->
      angle = Utils.degreesToRadians(@angle)
      x = @rinkCenter()[0] + @rinkRadius()*Math.cos(angle)
      y = @rinkCenter()[1] + @rinkRadius()*Math.sin(angle)
      [x, y]

  ActsAsObjectGroup.mixin(Goal)

  Goal
