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
  'server/arc_object',
  'server/rink',
  'server/collisions',
  'server/goal'
], function($, easel, socket, PlayerManager, Template, Renderer, GameWorld, GameWorldRenderer, WorldObject, ArcObject, Rink, Collisions, Goal) {
  $(function() {

    manager = new PlayerManager({socket: socket});
    template = new Template($('#stats'));
    renderer = new Renderer({player_manager: manager, output: template});

    rink = new Rink({object_attrs: { radius: 250, position: [250,250], anti: true, immovable: true}})

    ball = new WorldObject({position: [250,250], velocity: [0.2,0]})
    world = new GameWorld
    world.registerObject(ball)
    world.registerObject(rink)
    
    world.registerCollision( new Collisions.CircleWithAntiCircle(ball, rink) )

    world_renderer = new GameWorldRenderer({
      width: $('canvas').width(),
      height: $('canvas').height(),
      canvas: $('canvas')[0]
    })
    world_renderer.listen(world)

    manager.on('player:registered', function(player) { 
      player_goal = new Goal({ rink: rink, angle: 45, goalmouthAngle: 90})

      world.registerObject(player)
      world.registerObject(player_goal)

      player.moveTo([ 250, 250 ])
    });


    setInterval(function() {
      world.step(10);
    }, 10);

    
    
  });
});
