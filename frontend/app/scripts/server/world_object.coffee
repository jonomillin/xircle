define ['server/vector', 'server/graphic', 'server/shapes'], (Vector, Graphic, Shapes) ->
  class WorldObject
    constructor: (options={}) ->
      @position = options.position || [0,0]
      @velocity = options.velocity || [0,0]
      @radius = options.radius || 5
      shape = options.shape || Shapes.Circle.draw(radius: @radius)
      @graphic = new Graphic(shape)

      @anti = options.anti || false

    step: (timestep) ->
      @moveByTimestep(timestep)

    renderTo: (stage) =>
      if @graphic
        @graphic.renderTo(stage, @position)

    moveTo: ( posVec ) ->
      @position = posVec

    moveBy: ( posVec ) ->
      @position = Vector.add( @position, posVec )

    moveByTimestep: (timestep) ->
      @moveBy Vector.scale( timestep, @velocity )

    setVelocity: ( velocityVector) ->
      @velocity = velocityVector
