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

    socket.on('ip', function(ip) { alert(ip)})

    manager = new PlayerManager({socket: socket});
    template = new Template($('#stats'));
    renderer = new Renderer({player_manager: manager, output: template});

    rink = new Rink({ radius: 250, position: [250,250], anti: true, roughness: 0.05 })

    ball = new WorldObject({position: [250,250], velocity: [0.5,0], radius: 20})
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

    deg = 0
    manager.on('player:registered', function(player) { 
      player_goal = new Goal({ rink: rink, player: player, angle: deg, goalmouthAngle: 35})
      deg += 61

      player_goal.setupBallCollisions(ball)
      world.registerObject(player)
      world.registerObject(player_goal)


      player.moveTo([ 250, 250 ])
    });


    setInterval(function() {
      world.step(10);
    }, 10);

    
    
  });
});
