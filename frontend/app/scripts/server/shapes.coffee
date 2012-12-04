define ['easel', 'server/utils'], (easel, Utils) ->

  Graphics = easel.Graphics
  Shape = easel.Shape
  Shapes = {}


  Shapes.Circle = 
    draw: (options) ->
      color = options.color || [0,0,0]
      radius = options.radius || 5

      @graphics = new Graphics()
      @graphics.beginStroke(Graphics.getRGB(color))
      @graphics.drawCircle(0, 0, radius)
      @graphics
      new Shape(@graphics)

  Shapes.Arc =
    draw: (options) ->
      color = options.color || [0,0,0]
      console.log color
      radius = options.radius || 5
      arcAngles = options.arcAngles || [0,45]
      arcAngles = arcAngles.map (d) -> Utils.degreesToRadians(d)
      @graphics = new Graphics()
      @graphics.beginStroke(Graphics.getRGB(color...))
      @graphics.arc(0, 0, radius, arcAngles...)
      @graphics
      new Shape(@graphics)
    

  return Shapes
