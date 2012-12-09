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

var registerPlayer = function() {
  playerId++
  return playerId
}

var myIp = function() {
  var os = require('os');
  var ifaces = os.networkInterfaces();
  
  var ips = [];
  for (var device in ifaces) {
    ifaces[device].forEach(function(details) {
      if (details.family == 'IPv4' && details.address != '127.0.0.1') {
        ips.push(details.address);
      }
    });
  }
  return ips;
};

io.sockets.on('connection', function (socket) {
  //socket.on('gamespace:register', function(data) {
  //  gamespace = socket;
  //  gamespace.emit('gamespace:register:ack')
  //  players.forEach(function(playerId) {
  //    gamespace.emit('player:new', playerId);
  //  });
  //});
  socket.on('get_ip', function() {
    socket.emit('ip', myIp()[0]);
  });

  socket.emit('ip', myIp()[0]);

  socket.on('debug', function(data) {
    console.log('Debug', data)
  });

  socket.on('player:register', function(data) {
    var id = registerPlayer();
    console.log('Registered', id);
    io.sockets.emit('player:register', id, data);

    socket.on('player:move_by', function(offsetVector) {
      io.sockets.emit('player:move_by', id, offsetVector)
    });

    socket.on('disconnect', function() {
      socket.broadcast.emit('player:leave', id);
    });
  });
});
