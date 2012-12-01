define([
  'jquery',
  'shared/socket',
  'server/player_manager',
  'server/player_stats_template',
  'server/player_stats_renderer',
], function($, socket, PlayerManager, Template, Renderer) {
  $(function() {
    console.log(socket)
    socket.on('player:register', function(n) {
      console.log(n);
    });
    manager = new PlayerManager({socket: socket});
    template = new Template($('#stats'));
    renderer = new Renderer({player_manager: manager, output: template});
  });
});
