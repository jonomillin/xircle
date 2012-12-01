define ['easel'], (easel) ->

  class Graphic
    constructor: (shape) ->
      @shape = shape

    renderTo: (stage, position) =>
      @shape.x = position[0]
      @shape.y = position[1]
      stage.addChild(@shape)
      
    
