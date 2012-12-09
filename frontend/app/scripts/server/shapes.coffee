define ['easel', 'server/utils', 'server/sprites'], (easel, Utils, Sprites) ->

  Graphics = easel.Graphics
  Shape = easel.Shape
  Shapes = {}

  Shapes.Circle = 
    draw: (options) ->
      color = options.color || [0,0,0]
      radius = options.radius || 5
      fill = options.fill

      @graphics = new Graphics()
      @graphics.beginStroke(Graphics.getRGB(color))
      @graphics.beginBitmapFill(fill) if fill
      @graphics.drawCircle(0, 0, radius)
      @graphics
      new Shape(@graphics)

  Shapes.CircleIce =
    draw: (options) ->
      options.fill ||= Sprites.ice.image
      Shapes.Circle.draw(options)

  Shapes.CircleWater =
    draw: (options) ->
      options.fill ||= Sprites.water.image
      Shapes.Circle.draw(options)

  drawCharacter = (char_name) ->
    (options) ->
      container = new easel.Container()
      character = Sprites[char_name].clone()
      character.x = -20
      character.y = -20
      container.addChild(character)
      container

  Shapes.Snowman =
    draw: drawCharacter('snowman')
  Shapes.Santa = 
    draw: drawCharacter('santa')
  Shapes.Rudolf = 
    draw: drawCharacter('rudolf')
  Shapes.Tree = 
    draw: drawCharacter('tree')
  Shapes.Robin = 
    draw: drawCharacter('robin')
  Shapes.Baby = 
    draw: drawCharacter('baby')


  Shapes.Arc =
    draw: (options) ->
      color = options.color || [0,0,0]
      radius = options.radius || 5
      arcAngles = options.arcAngles || [0,45]
      arcAngles = arcAngles.map (d) -> Utils.degreesToRadians(d)
      @graphics = new Graphics()
      @graphics.beginStroke(Graphics.getRGB(color...))
      @graphics.arc(0, 0, radius, arcAngles...)
      @graphics
      new Shape(@graphics)
    

  return Shapes
