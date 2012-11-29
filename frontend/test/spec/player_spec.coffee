require ['scripts/remote_player'], (RemotePlayer) ->

  describe 'RemotePlayer', ->
    describe 'constructor', ->
      it 'should have a name', ->
        console.log 'described'
        player = new RemotePlayer(name: 'Pete')
        expect(player.name).to.equal 'Pete'
    
    describe 'register', ->
      it 'should register with the socket', ->
        socket = {emit: -> true}
        mock = sinon.mock(socket)
        mock.expects('emit').withArgs('register').once()

        player = new RemotePlayer(socket: socket)
        player.register()
        mock.verify()
