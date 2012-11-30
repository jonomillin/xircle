define([
  'shared/socket',
  'client/player'
], function(socket, Player) {
  player = new Player({name: "Phil", socket: socket})
  player.register()
});
