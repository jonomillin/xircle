define [], () ->
  Utils =
    degreesToRadians: (degrees) ->
      (degrees/360) * (2*Math.PI)

    radiansToDegrees: (radians) ->
      360*(radians / (2*Math.PI))

    angleInRange: (angle, range) ->
      lower = range[0]
      upper = range[1]
      if upper < lower
        lower = lower - 360
      angle = angle%360
      if angle > 180
        angle = 360 - angle
      lower <= angle and angle <= upper
  window.Utils = Utils
  Utils
