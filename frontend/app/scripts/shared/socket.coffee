define ['socketio'], (io) ->
  io = io.connect("http://#{window.location.hostname}:9990")
  io
