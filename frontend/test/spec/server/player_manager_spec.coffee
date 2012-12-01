define ['server/player_manager', 'shared/micro_event'], (PlayerManager, Event) ->

  describe 'server/PlayerManager', ->
    describe 'adding players', ->
      it 'should create a player on `player:register`', ->
        fake_socket = new Event
        manager = new PlayerManager(socket: fake_socket)
        fake_socket.emit('player:register', 1, {})

        expect(manager.playerCount()).to.equal 1

      it 'should update any listeners when player is added', ->
        fake_socket = new Event
        manager = new PlayerManager(socket: fake_socket)

        spy = sinon.spy()
        manager.on('change:player_count', spy)

        fake_socket.emit('player:register', 1, { name: 'Pete' })
        
        expect(spy.called).to.be.true
        expect(spy.getCall(0).args[0]).to.equal 1

    describe 'leaving players', ->
      it 'should remove a player on `player:leave`', ->
        fake_socket = new Event
        manager = new PlayerManager(socket: fake_socket)

        fake_socket.emit('player:register', 1, {})
        fake_socket.emit('player:leave', 1, {})

        expect(manager.playerCount()).to.equal 0

      it 'should not remove on random `player:leave` events', ->
        fake_socket = new Event
        manager = new PlayerManager(socket: fake_socket)

        fake_socket.emit('player:register', 1, {})
        fake_socket.emit('player:leave', 2, {}) #wrong player

        expect(manager.playerCount()).to.equal 1

      it 'should update any listeners when player is removed', ->
        fake_socket = new Event
        manager = new PlayerManager(socket: fake_socket)
        fake_socket.emit('player:register', 1, {})

        spy = sinon.spy()
        manager.on('change:player_count', spy)
        fake_socket.emit('player:leave', 1)
        expect(spy.called).to.be.true

      it 'should not update any listeners when fake player is removed', ->
        fake_socket = new Event
        manager = new PlayerManager(socket: fake_socket)
        fake_socket.emit('player:register', 1, {})

        spy = sinon.spy()
        manager.on('change:player_count', spy)
        fake_socket.emit('player:leave', 2)
        expect(spy.called).to.be.false
