define ['server/world_object', 'server/wraps_world_object'], (WorldObject, WrapsWorldObject) ->

  class Player
    constructor: (attrs = {}) ->
      @name = attrs.name
      @world_object ||= new WorldObject()
      @score = 0

    lostPoint: ->
      @score = @score - 1

  WrapsWorldObject.mixin(Player)
      
  return Player
