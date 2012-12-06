define ['server/utils'], (Utils) ->
  Vector =
    dotProduct: (v1, v2) ->
      v1[0]*v2[0] + v1[1]*v2[1]

    scale: (s, v) ->
      [ s*v[0], s*v[1] ]

    angleDeg: (v) ->
      Utils.radiansToDegrees(Vector.angleRad(v))

    angleRad: (v) ->
      rad = -1*Math.atan2(v[1], v[0])
      if rad < 0
        rad = 2*Math.PI + rad
      rad

    length: (v) ->
      Math.pow(
        v[0]*v[0] + v[1]*v[1]
      , 0.5)

    add: (v1, v2) ->
      [
        v1[0]+v2[0]
        v1[1]+v2[1]
      ]

    subtract: (v1,v2) ->
      [
        v1[0]-v2[0]
        v1[1]-v2[1]
      ]

    normalize: (v) ->
      l = @length(v)
      [
        v[0]/l,
        v[1]/l
      ]

    rotateRad: (v, radians=0) ->
      x = v[0]
      y = v[1]
      radians = radians * -1
      [
        x*Math.cos(radians) - y*Math.sin(radians),
        x*Math.sin(radians) + y*Math.cos(radians)
      ]

    reflect: (v, n) ->
      @subtract(
        v,
        @scale(2*@dotProduct(v,n), n)
      )
