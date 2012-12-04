define ['server/vector'], (Vector) ->
  Collisions = {}
  
  class Collisions.CircleWithAntiCircle
    constructor: (subject, collider) ->
      @subject = subject
      @collider = collider

    collide: ->
      @onCollision() if @doesCollide()

    collisionNormal: ->
      Vector.scale(-1, Vector.normalize(@separationVector()))

    separationVector: ->
      Vector.subtract(@subject.getPosition(), @collider.getPosition())

    overlapDistance: ->
      Vector.length(@separationVector()) + @subject.getRadius() - @collider.getRadius()

    doesCollide: ->
      @overlapDistance() >= 0

    onCollision: ->
      @fixVelocity()
      @fixOverlap()

    fixVelocity: ->
      normal = @collisionNormal()
      @subject.setVelocity Vector.reflect( @subject.getVelocity(), normal)

    fixOverlap: ->
      normal = @collisionNormal()
      correctionVector = Vector.scale(@overlapDistance(), normal)
      @subject.moveBy correctionVector

  class Collisions.CircleWithCircle extends Collisions.CircleWithAntiCircle
    collisionNormal: ->
      Vector.normalize(@separationVector())

    overlapDistance: ->
      @subject.getRadius() + @collider.getRadius() - Vector.length(@separationVector())

  
  return Collisions

