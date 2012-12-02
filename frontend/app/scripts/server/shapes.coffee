define ['easel'], (easel) ->

  Graphics = easel.Graphics
  Shape = easel.Shape
  Shapes = {}

  Shapes.Circle = 
    draw: (options) ->
      color = options.color || [0,0,0]
      radius = options.radius || 5

      @graphics = new Graphics()
      @graphics.beginStroke(Graphics.getRGB(@color))
      @graphics.drawCircle(0, 0, radius)
      @graphics
      new Shape(@graphics)
    

  return Shapes
