define ['shared/micro_event'], (Event) ->

  class GameWorld
    constructor: ->
      @objects = []
      @collisions = []

    registerCollision: (collision) ->
      @collisions.push collision

    registerObject: (object) ->
      @objects.push object

    eachObject: (cb) ->
      @objects.forEach(cb)

    eachCollision: (cb) ->
      @collisions.forEach(cb)

    step: (timestep) ->
      @eachObject (o) -> o.step(timestep)
      @eachCollision (o) -> o.collide()
      @emit('stepped')

  Event.mixin(GameWorld)

  GameWorld
