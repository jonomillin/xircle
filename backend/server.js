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
  return playerId
}

io.sockets.on('connection', function (socket) {
  //socket.on('gamespace:register', function(data) {
  //  gamespace = socket;
  //  gamespace.emit('gamespace:register:ack')
  //  players.forEach(function(playerId) {
  //    gamespace.emit('player:new', playerId);
  //  });
  //});

  socket.on('player:register', function(data) {
    var id = registerPlayer();
    console.log('Registered', id);
    io.sockets.emit('player:register', id, {});

    socket.on('player:move_by', function(offsetVector) {
      gamespace.emit('player:move_by', id, offsetVector)
    });

    socket.on('disconnect', function() {
      socket.broadcast.emit('player:leave', id);
    });
  });
});
