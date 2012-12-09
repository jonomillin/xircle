define([
  'underscore',
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
  'server/vector',
  'server/sounds'

], function(_, $, easel, socket, PlayerManager, Template, Renderer, GameWorld, GameWorldRenderer, WorldObject, ArcObject, Rink, Ball, Collisions, Goal, Shapes, Player, Vector, Sounds) {
  $(function() {

    socket.on('ip', function(ip) { 
      $('#ip').text('http://'+ip+':3501');
    })

    socket.emit('get_ip');

    manager = new PlayerManager({socket: socket});
    template = new Template($('#stats'));
    renderer = new Renderer({player_manager: manager, output: template});

    var center = [500,384]
    rink = new Rink({ radius: 250, position: center, anti: true, roughness: 0.05 })

    ball = new Ball({
      position: center,
      velocity: [0,0],
      radius: 20
    })

    window.Game = {
      wait: function() {
        ball.moveTo(center);
        ball.setVelocity([0,0]);
      },
      loses: function(name) {
        $('body').html("<h1>"+name+" Loses :'(</h1>")
        _.delay(function() {
          window.location.reload()
        },2000)

      },
      spinStart: function() {
        Game.wait();

        var angle = 0;
        var interval = setInterval(function() {
          angle = new Date().getTime() % 360;
          ball.setAngle(angle);
        }, 1);

        window.Sounds = Sounds
        setTimeout(function() {
          clearInterval(interval);
          //ball.setVelocity(Vector.rotateDeg([0.4,0], angle));
          ball.setVelocity(Vector.rotateDeg([0.4,0], 0));
        }, 2000 + Math.random()*2000);
      },
    }

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

    var deg = 0

    var player_count = 0;
    manager.on('player:registered', function(player) { 
      player_goal = new Goal({ rink: rink, player: player, angle: deg, goalmouthAngle: 35})
      deg += 60

      player_goal.setupBallCollisions(ball)
      world.registerObjectStart(player_goal)
      world.registerObject(player)
      console.log(world.objects)

      player_count ++ 
      if (player_count == 1) {
        Game.spinStart();
      }
    });


    setInterval(function() {
      world.step(10);
    }, 10);

    
    
  });
});
