define ['server/vector', 'server/graphic', 'server/shapes'], (Vector, Graphic, Shapes) ->
  class WorldObject
    constructor: (options={}) ->
      @position = options.position || [0,0]
      @velocity = options.velocity || [0,0]
      @radius = options.radius || 5
      shape = options.shape || Shapes.Circle.draw(radius: @radius)
      @graphic = new Graphic(shape)

    step: (timestep) ->
      @moveByTimestep(timestep)

    renderTo: (stage) =>
      if @graphic
        @graphic.renderTo(stage, @position)

    moveByTimestep: (timestep) ->
      @position = Vector.add( @position, Vector.scale(timestep, @velocity) )
