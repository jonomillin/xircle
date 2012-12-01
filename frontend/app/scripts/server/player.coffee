define ['server/world_object'], (WorldObject) ->

  class Player
    constructor: (attrs = {}) ->
      @name = attrs.name
      @world_object ||= new WorldObject()
      
    moveTo: (args...) => @world_object.moveTo(args...)
    moveBy: (args...) => @world_object.moveBy(args...)
    
      
  return Player
