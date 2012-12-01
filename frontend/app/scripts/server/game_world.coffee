define ['shared/micro_event'], (Event) ->

  class GameWorld
    constructor: ->
      @objects = []

    registerObject: (object) ->
      @objects.push object

    eachObject: (cb) ->
      @objects.forEach(cb)

    step: (timestep) ->
      @eachObject (o) -> o.step(timestep)
      @emit('stepped')

  Event.mixin(GameWorld)

  GameWorld
