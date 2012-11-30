window.require = ({
  urlArgs: "bust=" +  (new Date()).getTime(),
  
  paths: {
    underscore: '/components/underscore/underscore',
    jquery: '/components/jquery/jquery',
    socketio: '/scripts/socket.io'
  },

  shim: {
    'underscore': {
      deps: [],
      exports: '_'
    },
    'jquery': {
      deps: [],
      exports: 'jQuery'
    },
    'socketio': {
      deps: [],
      exports: 'io'
    }
  }
})
