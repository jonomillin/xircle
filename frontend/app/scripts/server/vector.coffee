define ['server/utils'], (Utils) ->
  Vector =
    dotProduct: (v1, v2) ->
      v1[0]*v2[0] + v1[1]*v2[1]

    scale: (s, v) ->
      [
        v[0]*s,
        v[1]*s
      ]

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

    reflect: (v, n) ->
      @subtract(
        v,
        @scale(2*@dotProduct(v,n), n)
      )
