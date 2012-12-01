define ['server/player_manager', 'shared/micro_event'], (PlayerManager, Event) ->

  describe 'server/PlayerManager', ->
    describe 'adding players', ->
      before ->
        @fake_socket = new Event
        @manager = new PlayerManager(socket: @fake_socket)

      it 'should create a player on `player:register`', ->
        @fake_socket.emit('player:register', 1, {})
        @manager.playerCount().should.equal 1

      it 'should update any listeners when player is added', ->
        count_spy = sinon.spy()
        @manager.on('change:player_count', count_spy)
        register_spy = sinon.spy()
        @manager.on('player:registered', register_spy)

        @fake_socket.emit('player:register', 1, { name: 'Pete' })
        count_spy.called.should.be.true
        count_spy.getCall(0).args[0].should.equal 1
        register_spy.called.should.be.true

    describe 'leaving players', ->
      it 'should remove a player on `player:leave`', ->
        @fake_socket.emit('player:register', 1, {})
        @fake_socket.emit('player:leave', 1, {})

        @manager.playerCount().should.equal 0

      it 'should not remove on random `player:leave` events', ->
        @fake_socket.emit('player:register', 1, {})
        @fake_socket.emit('player:leave', 2, {}) #wrong player

        @manager.playerCount().should.equal 1

      it 'should update any listeners when player is removed', ->
        @fake_socket.emit('player:register', 1, {})

        count_spy = sinon.spy()
        @manager.on('change:player_count', count_spy)
        register_spy = sinon.spy()
        @manager.on('player:left', register_spy)
        
        @fake_socket.emit('player:leave', 1)
        count_spy.called.should.be.true
        register_spy.called.should.be.true

      it 'should not update any listeners when fake player is removed', ->
        @fake_socket.emit('player:register', 1, {})

        spy = sinon.spy()
        @manager.on('change:player_count', spy)
        @fake_socket.emit('player:leave', 2)
        spy.called.should.be.false

    describe 'moving players', ->
      it 'should move the player', ->

        player = { moveBy: -> true }
        mock = sinon.mock(player).expects('moveBy').withArgs([1,-1])
        
        @manager.players[1] = player
        @fake_socket.emit('player:move_by', 1, [1,-1])

        mock.verify().should.be.true


        
