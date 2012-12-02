define ['server/world_object', 'underscore'], (WorldObject, _) ->

  class Rink
    constructor: (attrs = {}) ->
      @world_object ||= new WorldObject( attrs.object_attrs || {})


