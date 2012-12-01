define([
  'jquery',
  'shared/socket',
  'client/player',
  'client/touch_manager'
], function($, socket, Player, TouchManager) {
  $(function() {
    socket.on('connect', function() {
      player = new Player({name: "Phil", socket: socket})
      player.register()

      touch_manager = new TouchManager({ el: $('#touchy')[0] })
      touch_manager.setup()
      
      touch_manager.on('moved_by', function(data) {
        socket.emit('player:move_by', data.px);
      });
    });
  });

  
});
