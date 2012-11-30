define ['scripts/server/player', 'scripts/shared/micro_event'], (Player, Event) ->

  class PlayerManager
    constructor: (options) ->
      @socket = options.socket
      @players = []

      @bindToSocket()

    bindToSocket: ->
      @socket.on 'player:new', @onNewPlayer

    onNewPlayer: (player_opts) =>
      player = new Player(player_opts)
      @players.push player
      @emit('player:registered', player, @playerCount())
      
    playerCount: ->
      @players.length

  Event.mixin(PlayerManager)

  return PlayerManager
