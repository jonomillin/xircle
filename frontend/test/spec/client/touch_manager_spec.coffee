define ['client/touch_manager', 'jquery'], (TouchManager, $) ->
  describe 'client/TouchManager', ->
    before ->
      @$element = $('<div>')
      $('body').append @$element
      @el = @$element[0]

    after ->
      @$element.remove()
    
    it 'accepts an element', ->
      new TouchManager(el: @el).el.should.equal @el

    describe 'event binding', ->
      it 'binds to touch start events on the el', ->
        manager = new TouchManager(el: @el)

        mock = sinon.mock(@el)
        mock.expects('addEventListener').withArgs('touchstart', manager.onTouchStart)
        mock.expects('addEventListener').withArgs('touchmove', manager.onTouchMove)
        manager.setup()
        mock.verify().should.be.true

    it 'emits delta movements', ->
      $(@el).width(100)
            .height(50)
      manager = new TouchManager(el: @el)
      spy = sinon.spy()
      manager.on('moved_by', spy)
      manager.setup()

      start_evt =
        touches: [
          { screenX: 50, screenY: 60 }
        ]

      move_evts =
        [
          { touches: [ { screenX: 60, screenY: 50 } ] }
          { touches: [ { screenX: 65, screenY: 45 } ] }
        ]

      manager.onTouchStart(start_evt)
      move_evts.forEach( (evt) -> manager.onTouchMove(evt) )

      spy.called.should.be.true
      spy.calledWith({ px: [10, -10], normalized: [0.1, -0.2] }).should.be.true
      spy.calledWith({ px: [5, -5], normalized: [0.05, -0.1] }).should.be.true

  
