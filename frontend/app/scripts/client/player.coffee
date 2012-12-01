define [], ->

  class Player
    constructor: (attrs) ->
      @socket = attrs.socket
      @name = attrs.name

    register: ->
      @socket.emit('player:register', {name: @name})

    moveBy: (offsetVector) ->
      @socket.emit('player:move_by', offsetVector)

  return Player
