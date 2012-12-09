define ['easel', 'server/wraps_world_object'], (easel, WrapsWorldObject) ->
  
  class Score
    constructor: (opts={}) ->
      height = 25
      @text = new easel.Text('', "#{height}px helvetica")
      @text.x = opts.pos[0]
      @text.y = opts.pos[1] - height/2
      @score = 0
      @title = opts.title || "Score"
      @updateText()

    step: ->

    updateText: ->
      @text.text = "#{@title}: "+@score

    renderTo: (stage) ->
      stage.addChild(@text)

    lostPoint: =>
      @score = @score - 1
      @updateText()

  Score
