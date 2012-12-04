define [], () ->
  Utils =
    degreesToRadians: (degrees) ->
      (degrees/360) * (2*Math.PI)
