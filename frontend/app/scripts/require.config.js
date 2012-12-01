window.require = ({
  urlArgs: "bust=" +  (new Date()).getTime(),
  
  paths: {
    underscore: '/components/underscore/underscore',
    jquery: '/components/jquery/jquery',
    socketio: '/scripts/socket.io',
    easel: '/scripts/easel'
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
    },
    'easel': {
      deps: [],
      exports: 'createjs'
    }
  }
})
