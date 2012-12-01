define ['server/player', 'shared/micro_event', 'underscore'], (Player, Event, _) ->

  class PlayerManager
    constructor: (options) ->
      @socket = options.socket
      @players = {}

      @bindToSocket()

    bindToSocket: ->
      @socket.on 'player:register', @onPlayerRegister
      @socket.on 'player:leave', @onPlayerLeave

    onPlayerRegister: (player_id, player_opts) =>
      console.log 'player register'
      player = new Player(player_opts)
      @players[player_id] = player
      @emitPlayerCount()
    
    onPlayerLeave: (player_id, player_opts) =>
      if player = @players[player_id]
        delete(@players[player_id])
        @emitPlayerCount()
      
    emitPlayerCount: ->
      @emit 'change:player_count', @playerCount()

    playerCount: ->
      _.keys(@players).length

  Event.mixin(PlayerManager)

  return PlayerManager
