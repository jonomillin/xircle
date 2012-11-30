define ['socketio'], (io) ->
  io = io.connect('http://localhost:9990')
  io
