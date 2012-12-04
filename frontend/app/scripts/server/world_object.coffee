define ['server/vector', 'server/graphic', 'server/shapes'], (Vector, Graphic, Shapes) ->
  class WorldObject
    constructor: (options={}) ->
      @position = options.position || [0,0]
      @velocity = options.velocity || [0,0]
      @radius = options.radius || 5
      @color = options.color || [0,0,0]
      @extractExtraOptions(options)

      shape = options.shape || @defaultShape()
      @graphic = new Graphic(shape)

      @anti = options.anti || false

    extractExtraOptions: (options) ->
      #
    defaultShape: ->
      Shapes.Circle.draw(radius: @radius, color: @color)

    step: (timestep) ->
      @moveByTimestep(timestep)

    renderTo: (stage) =>
      if @graphic
        @graphic.renderTo(stage, @position)

    getRadius: -> @radius

    getPosition: -> @position
    moveTo: ( posVec ) ->
      @position = posVec
    moveBy: ( posVec ) ->
      @position = Vector.add( @position, posVec )
    moveByTimestep: (timestep) ->
      @moveBy Vector.scale( timestep, @velocity )

    getVelocity: -> @velocity
    setVelocity: ( velocityVector) ->
      @velocity = velocityVector
