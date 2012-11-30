var express = require('express')
  , app = express()
  , http = require('http')
  , server = http.createServer(app)
  , io = require('socket.io').listen(server)
  , port = process.argv[2] || '9990'
  , fs = require('fs')
  , exec = require('child_process').exec
  ;
  
server.listen(port)

var players = [];
var gamespace;
var playerId = 0;

registerPlayer = function() {
  playerId++
  if(gamespace) {
    gamespace.emit('player:new', playerId);
  } else {
    players.push(playerId);
  }
  return playerId
}

io.sockets.on('connection', function (socket) {
  socket.on('gamespace:register', function(data) {
    gamespace = socket;
    gamespace.emit('gamespace:register:ack')
    players.forEach(function(playerId) {
      gamespace.emit('player:new', playerId);
    });
  });

  socket.on('player:register', function(data) {
    socket.broadcast.emit('player:register', data);
    console.log('Registered');
    var id = registerPlayer();
    socket.on('move', function(pos) {
      if (gamespace) { 
        gamespace.emit('player:'+id+':move', pos);
      }
    });
  });
});
