define ['server/world_object', 'server/wraps_world_object'], (WorldObject, WrapsWorldObject) ->

  class Rink
    constructor: (attrs = {}) ->
      @world_object ||= new WorldObject( attrs )

    
  
  WrapsWorldObject.mixin(Rink)

  Rink
