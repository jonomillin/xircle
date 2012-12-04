define ['server/utils', 'mixins/acts_as_object_group', 'server/arc_object', 'server/rink'], (Utils, ActsAsObjectGroup, ArcObject, Rink) ->
  class PlayerRink extends Rink

  class Goal
    constructor: (options = {}) ->
      @rink = options.rink
      @angle = options.angle
      @goalmouthAngle = options.goalmouthAngle
      @buildGoalmouth()
      @buildPlayerRink()

    buildGoalmouth: ->
      @registerObject new ArcObject
        radius: @rinkRadius()
        position: @rinkCenter()
        arcAngles: [@angle - @goalmouthAngle/2, @angle + @goalmouthAngle/2]
        color: [255,0,0]

    buildPlayerRink: ->
      @registerObject new Rink
        object_attrs: 
          position: @calculatePlayerRinkCenter()
          radius: 50

    rinkCenter: -> @rink.world_object.position
    rinkRadius: -> @rink.world_object.radius

    calculatePlayerRinkCenter: ->
      angle = Utils.degreesToRadians(@angle)
      x = @rinkCenter()[0] + @rinkRadius()*Math.cos(angle)
      y = @rinkCenter()[1] + @rinkRadius()*Math.sin(angle)
      [x, y]

  ActsAsObjectGroup.mixin(Goal)

  Goal
