define ['shared/micro_event', 'jquery'], (Event, $) ->
  class ElementPositionHandler
    constructor: (el) ->
      @el = el
      @$el = $(@el)
      @height = el.clientHeight
      @width = el.clientWidth
    
    normalize: (posVector) ->
      [
        posVector[0] / @width,
        posVector[1] / @height
      ]

  class DeltaTouchManager
    constructor: (options) ->
      @el = options.el

    setup: ->
      @bindHandlers()
      @elementPositionHandler = new ElementPositionHandler(@el)

    bindHandlers: =>
      if @el
        document.addEventListener('touchmove', ((e)->e.preventDefault()), false)
        @el.addEventListener('touchstart', @onTouchStart)
        @el.addEventListener('touchmove', @onTouchMove)

    onTouchStart: (evt) =>
      @lastTouchPos = @getTouchPos(evt)

    onTouchMove: (evt) =>
      pos = @getTouchPos(evt)
      delta = [
        pos[0] - @lastTouchPos[0],
        pos[1] - @lastTouchPos[1],
      ]
      @lastTouchPos = pos
      @emitPos(delta)

    getTouchPos: (evt) ->
      touch = evt.touches[0]
      [touch.screenX, touch.screenY]

    emitPos: (posVector) =>
      data = { px: posVector }
      data.normalized = @elementPositionHandler.normalize(data.px)
      console.log data
      @emit('moved_by', data)

  Event.mixin(DeltaTouchManager)

  return DeltaTouchManager
