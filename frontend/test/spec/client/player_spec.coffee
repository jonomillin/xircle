require ['scripts/client/player'], (Player) ->

  console.log(Player)
  describe 'client/Player', ->
    describe 'constructor', ->
      it 'should have a name', ->
        player = new Player(name: 'Pete')
        expect(player.name).to.equal 'Pete'
    
    describe 'register', ->
      it 'should register with the socket', ->
        socket = {emit: -> true}
        mock = sinon.mock(socket)
        mock.expects('emit').withArgs('player:register', {name: 'Pete'}).once()

        player = new Player(socket: socket, name: 'Pete')
        player.register()
        mock.verify()
