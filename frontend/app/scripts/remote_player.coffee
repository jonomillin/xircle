define [], ->

  class RemotePlayer
    constructor: (attrs) ->
      @socket = attrs.socket
      @name = attrs.name

    register: ->
      @socket.emit('register')

  return RemotePlayer
