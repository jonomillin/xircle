define ['jquery', 'server/utils', 'mixins/acts_as_object_group', 'server/arc_object', 'server/rink', 'server/collisions', 'server/shapes', 'server/sounds', 'server/score'], ($,Utils, ActsAsObjectGroup, ArcObject, Rink, Collisions, Shapes, Sounds, Score) ->
  class PlayerRink extends Rink

  class Goal
    constructor: (options = {}) ->
      @rink = options.rink
      @angle = options.angle
      @goalmouthAngle = options.goalmouthAngle

      @parts = {}
      @player = options.player
      @buildGoal()
      @score = 0

    setupBallCollisions: (ball) =>
      @registerCollision new Collisions.CircleWithAntiArc ball, @parts.goalMouth, =>
        Sounds.music.pause()
        snds = [Sounds.cry1, Sounds.cry2, Sounds.cry3]
        snds[Math.floor(Math.random()*3)].play()
        @parts.score.lostPoint()
        if @parts.score.score <= -5
          window.Game.loses(@player.name)
        else
          window.Game.spinStart()
        
      @registerCollision new Collisions.CircleWithCircle ball, @player, {
        onCollision: =>
          console.log 'onCollision'
          snds = [Sounds.cough1, Sounds.cough2, Sounds.cough3]
          snds[Math.floor(Math.random()*3)].play()
        delay: 30
      }

    setupPlayerCollisions:  ->
      @registerCollision new Collisions.CircleWithAntiCircle(@player, @parts.playerRink)
      @registerCollision new Collisions.CircleWithAntiCircle(@player, @rink)

    buildGoal: ->
      @buildGoalmouth()
      @buildPlayerRink()
      @setupPlayerCollisions()
      @buildScore()

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
    
    buildScore: ->
      @parts.score = new Score({
        pos: @calculateTextPosition(),
        title: @player.name
      })
      @registerObject @parts.score

    rinkCenter: -> @rink.world_object.position
    rinkRadius: ->
      @rink.world_object.radius - 1

    calculatePlayerRinkCenter: ->
      angle = Utils.degreesToRadians(@angle)
      x = @rinkCenter()[0] + @rinkRadius()*Math.cos(angle)
      y = @rinkCenter()[1] + @rinkRadius()*Math.sin(angle)
      [x, y]

    textRadius: (neg) ->
      if neg
        @rinkCenter()[1] - 10
      else
        @rinkRadius() + 30

    calculateTextPosition: ->
      angle = Utils.degreesToRadians(@angle)
      negative = @angle > 90 and @angle < 270
      x = @rinkCenter()[0] + @textRadius(negative)*Math.cos(angle)
      y = @rinkCenter()[1] + @textRadius(negative)*Math.sin(angle)
      if negative
        x = x - 50
        x = 0 if x<0
      else
        x = x + 55

      [x, y]

  ActsAsObjectGroup.mixin(Goal)

  Goal
