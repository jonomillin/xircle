define ['server/vector', 'server/graphic', 'server/shapes', 'server/low_pass_filter'], (Vector, Graphic, Shapes, LowPassFilter) ->

  class WorldObject
    constructor: (options={}) ->
      @position = options.position || [0,0]
      @velocity = options.velocity || [0,0]
      @radius = options.radius || 20
      @color = options.color || [0,0,0]
      @angle = 270
      @roughness = options.roughness || false
      @extractExtraOptions(options)

      shape = @buildShape(options.shape || @defaultShape())
      @graphic = new Graphic(shape)

      @anti = options.anti || false
      @move_filter = new LowPassFilter(5)

    extractExtraOptions: (options) ->
      
    defaultShape: -> Shapes.Circle
    buildShape: (shape) -> shape.draw(@shapeAttributes())
    shapeAttributes: ->
      { radius: @radius, color: @color, angle: @angle }

    step: (timestep) ->
      @moveByTimestep(timestep)

    renderTo: (stage) =>
      if @graphic
        @graphic.renderTo(stage, @position)

    getRoughness: -> @roughness
    getRadius: -> @radius
    getPosition: -> @position

    moveTo: ( posVec ) ->
      angle = Vector.angleDeg(Vector.subtract( @position, posVec))
      @setAngle(angle)
      @position = posVec

    moveBy: ( posVec, silent=false ) ->
      unless silent or posVec[0] == 0 and posVec[1] == 0
        @move_filter.push(posVec)
        angle = Vector.angleDeg(@move_filter.value())
        @setAngle( ((angle - 90) % 360))
        
      @position = Vector.add( @position, posVec )

    moveByTimestep: (timestep) ->
      unless @velocity[0] == 0 and @velocity[1] == 0
        @moveBy Vector.scale( timestep, @velocity )

    getVelocity: -> @velocity
    setVelocity: ( velocityVector) ->
      @velocity = velocityVector
    setAngle: ( angle ) ->
      @graphic.shape.rotation = -1*angle

