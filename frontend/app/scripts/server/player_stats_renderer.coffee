define [], () ->
  class PlayerStatsRenderer
    constructor: (options) ->
      @player_manager = options.player_manager
      @output = options.output
      
      @bindChanges()

    bindChanges: ->
      @player_manager.on 'player:registered', (player, n) => @renderPlayerCount(n)

    renderPlayerCount: (player_count) =>
      @output.display player_count: "#{player_count} players"
