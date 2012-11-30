define ['server/player', 'shared/micro_event'], (Player, Event) ->

  class PlayerManager
    constructor: (options) ->
      @socket = options.socket
      @players = []

      @bindToSocket()

    bindToSocket: ->
      @socket.on 'player:register', @onNewPlayer

    onNewPlayer: (player_opts) =>
      console.log 'onnew'
      player = new Player(player_opts)
      @players.push player
      @emit('player:registered', player, @playerCount())
      
    playerCount: ->
      @players.length

  Event.mixin(PlayerManager)

  return PlayerManager
