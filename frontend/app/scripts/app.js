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
  'server/ball',
  'server/collisions',
  'server/goal',
  'server/shapes',
  'server/player',

], function($, easel, socket, PlayerManager, Template, Renderer, GameWorld, GameWorldRenderer, WorldObject, ArcObject, Rink, Ball, Collisions, Goal, Shapes, Player) {
  $(function() {

    socket.on('ip', function(ip) { console.log(ip+':3501')})

    manager = new PlayerManager({socket: socket});
    template = new Template($('#stats'));
    renderer = new Renderer({player_manager: manager, output: template});

    rink = new Rink({ radius: 250, position: [250,250], anti: true, roughness: 0.05 })

    ball = new Ball({
      position: [250,250],
      velocity: [0.4,0],
      radius: 20
    })
    world = new GameWorld
    world.registerObject(rink)
    world.registerObject(ball)
    
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
      deg += 60

      player_goal.setupBallCollisions(ball)
      world.registerObjectBefore(player_goal, rink)
      world.registerObject(player)

    });


    setInterval(function() {
      world.step(10);
    }, 10);

    
    
  });
});
