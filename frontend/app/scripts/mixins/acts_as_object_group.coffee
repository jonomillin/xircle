define ['mixins/mixin', 'shared/micro_event', 'underscore'], (Mixin, Event, _) ->

  class ActsAsObjectGroup extends Mixin
    initObjects: -> @objects ||= []
    initCollisions: -> @collisions ||= []
      
    eachObject: (cb) -> 
      @initObjects() unless @objects
      @objects.forEach(cb)
    eachCollision: (cb) ->
      @initCollisions() unless @collisions
      @collisions.forEach(cb)

    registerObjectBefore: (object, before) ->
      before_index = _.indexOf(@objects, before)
      @objects.splice(0, before_index, object)

    registerObject: (object) ->
      @initObjects()
      @objects.push object
    registerCollision: (collision) ->
      @initCollisions()
      @collisions.push collision

    onStep: ->

    step: (timestep) ->
      @eachObject (o) -> o.step(timestep)
      @eachCollision (o) -> o.collide()
      @onStep()
      @emit('stepped')

    renderTo: (stage) ->
      @eachObject (o) -> o.renderTo(stage)

  Event.mixin(ActsAsObjectGroup)

  return ActsAsObjectGroup
