define([
  'jquery',
  'shared/socket',
  'server/player_manager',
  'server/player_stats_template',
  'server/player_stats_renderer',
  'server/game_world',
  'server/game_world_renderer',
  'server/world_object',
  'easel'
], function($, socket, PlayerManager, Template, Renderer, GameWorld, GameWorldRenderer, WorldObject, easel) {
  $(function() {

    manager = new PlayerManager({socket: socket});
    template = new Template($('#stats'));
    renderer = new Renderer({player_manager: manager, output: template});


    ball = new WorldObject({position: [50,50], velocity: [0.1,-0.2]})
    world = new GameWorld
    world.registerObject(ball)
    world_renderer = new GameWorldRenderer({width: 500, height: 500, canvas: $('canvas')[0]})
    world_renderer.listen(world)

    manager.on('player:registered', function(player) { 
      console.log(player)
      world.registerObject(player.world_object)
      player.moveTo([ 50, 50 ])
    });


    setInterval(function() {
      world.step(10);
    }, 10);

    
    
  });
});
