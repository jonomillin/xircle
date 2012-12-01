define ['easel'], (easel) ->

  Stage = easel.Stage

  class GameWorldRenderer
    constructor: (options) ->
      @width = options.width
      @height = options.height
      @stage = options.stage || new Stage(options.canvas)

    listen: (world) =>
      world.on('stepped', => @render(world))

    render: (world) =>
      world.eachObject (o) => o.renderTo(@stage)
      @stage.update()
