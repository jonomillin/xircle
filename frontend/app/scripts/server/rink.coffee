define ['server/world_object', 'server/wraps_world_object', 'server/shapes'], (WorldObject, WrapsWorldObject, Shapes) ->

  class Rink
    constructor: (attrs = {}) ->
      attrs.shape ||= Shapes.CircleIce
      @world_object ||= new WorldObject( attrs )
  
  WrapsWorldObject.mixin(Rink)

  Rink
