define ['scripts/server/player_manager', 'scripts/shared/micro_event'], (PlayerManager, Event) ->

  describe 'server/PlayerManager', ->
    describe 'constructor', ->
      it 'should create a player on `player:new`', ->
        fake_socket = new Event
        manager = new PlayerManager(socket: fake_socket)
        fake_socket.emit('player:new', {})

        expect(manager.playerCount()).to.equal 1

      it 'should update any listeners when player is added', ->
        fake_socket = new Event
        manager = new PlayerManager(socket: fake_socket)

        spy = sinon.spy()
        manager.on('player:registered', spy)

        fake_socket.emit('player:new', { name: 'Pete' })
        
        expect(spy.called).to.be.true
        expect(spy.getCall(0).args[0].name).to.equal 'Pete'
        expect(spy.getCall(0).args[1]).to.equal 1
