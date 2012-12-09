define ['server/world_object', 'server/wraps_world_object', 'server/shapes'], (WorldObject, WrapsWorldObject, Shapes) ->

  class Ball
    constructor: (attrs = {}) ->
      #attrs.shape = Shapes.Snowman
      @world_object ||= new WorldObject( attrs )
  
  WrapsWorldObject.mixin(Ball)

  Ball
