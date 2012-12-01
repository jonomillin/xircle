require ['client/player'], (Player) ->

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

    describe 'moveBy', ->
      it 'should move the player', ->
        socket = { emit: -> true }
        mock = sinon.mock(socket)
        mock.expects('emit').withArgs('player:move_by', [1, -1])
        player = new Player(socket: socket, name: 'Pete')
        player.moveBy([1, -1])
        mock.verify()
        
