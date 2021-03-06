define([
  'jquery',
  'shared/socket',
  'client/player',
  'client/touch_manager'
], function($, socket, Player, TouchManager) {
  $(function() {
    $('#touchy').hide();
    $('form').submit(function(e) { 
      e.preventDefault()
      var name = $('input[name="name"]').val();
      $(this).remove();
      $('#touchy').show();
      if(socket.socket.connected) {
        register(name);
      } else {
        socket.on('connect', function() { 
          register(name) } );
      }
    });

    //$('#touchy').show()
    //$('form').remove()
    //register('phil')
    
    function register(player_name) { 

      //socket.on('connect', function() {
        console.log('regiser');
        var player = new Player({name: player_name, socket: socket})
        player.register()

        touch_manager = new TouchManager({ el: $('#touchy')[0] })
        touch_manager.setup()
        
        touch_manager.on('moved_by', function(data) {
          socket.emit('player:move_by', data.px);
        });
      //});
    }
  });

  
});
