define([
  'jquery',
  'easel',
  'shared/socket',
  'server/player_manager',
  'server/player_stats_template',
  'server/player_stats_renderer',
  'server/game_world',
  'server/game_world_renderer',
  'server/world_object',
  'server/rink',
  'server/collisions'
], function($, easel, socket, PlayerManager, Template, Renderer, GameWorld, GameWorldRenderer, WorldObject, Rink, Collisions) {
  $(function() {

    manager = new PlayerManager({socket: socket});
    template = new Template($('#stats'));
    renderer = new Renderer({player_manager: manager, output: template});

    rink = new Rink({object_attrs: { radius: 250, position: [250,250], anti: true, immovable: true}})

    ball = new WorldObject({position: [250,250], velocity: [0.1,-0.2]})
    world = new GameWorld
    world.registerObject(ball)
    world.registerObject(rink.world_object)
    
    world.registerCollision( new Collisions.CircleWithAntiCircle(ball, rink.world_object) )

    world_renderer = new GameWorldRenderer({
      width: $('canvas').width(),
      height: $('canvas').height(),
      canvas: $('canvas')[0]
    })
    world_renderer.listen(world)

    manager.on('player:registered', function(player) { 
      console.log(player)
      world.registerObject(player.world_object)
      world.registerCollision( new Collisions.CircleWithCircle(ball, player.world_object));
      world.registerCollision( new Collisions.CircleWithAntiCircle(player.world_object, rink.world_object));
      player.moveTo([ 250, 250 ])
    });


    setInterval(function() {
      world.step(10);
    }, 10);

    
    
  });
});
