define ['server/vector'], (Vector) ->
  Collisions = {}
  
  class Collisions.CircleWithAntiCircle
    constructor: (subject, antiCircle) ->
      @subject = subject
      @antiCircle = antiCircle

    collide: ->
      if @doesCollide()
        @onCollision()
        @fixOverlap()

    separationVector: ->
      Vector.subtract(@subject.position, @antiCircle.position)

    overlapDistance: ->
      Vector.length(@separationVector()) + @subject.radius - @antiCircle.radius

    doesCollide: ->
      @overlapDistance() >= 0

    onCollision: ->
      normal = Vector.normalize(@separationVector())
      @subject.setVelocity Vector.reflect( @subject.velocity, normal)

    fixOverlap: ->
      normal = Vector.normalize(@separationVector())
      correctionVector = Vector.scale(-1*@overlapDistance(), normal)
      @subject.moveBy correctionVector

  class Collisions.CircleWithCircle
    constructor: (subject, circle) ->
      @subject = subject
      @circle = circle

    collide: ->
      sepVector = Vector.subtract(@circle.position, @subject.position)
      if Vector.length(sepVector) < @circle.radius + @subject.radius
        normal = Vector.normalize(sepVector)
        @subject.velocity = Vector.reflect( @subject.velocity, normal)

  return Collisions

