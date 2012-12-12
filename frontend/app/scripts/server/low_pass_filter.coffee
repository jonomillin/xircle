define ['underscore'], (_) ->
  class LowPassFilter
    constructor: (length, preload) ->
      preload ||= [0,0]
      @queue = []
      @queue.unshift(preload) for i in [1..length]
      @length = length
    
    push: (val) ->
      @queue.pop()
      @queue.unshift(
        [
          val[0]/@length,
          val[1]/@length
        ]
      )

    value: ->
      _.inject @queue, ((memo,vector) ->
        [ memo[0]+vector[0], memo[1]+vector[1] ]), [0,0]
      

      
      
