define ['server/world_object', 'server/wraps_world_object'], (WorldObject, WrapsWorldObject) ->

  class Player
    constructor: (attrs = {}) ->
      @name = attrs.name
      @world_object ||= new WorldObject()
      
  WrapsWorldObject.mixin(Player)
      
  return Player
