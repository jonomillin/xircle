define ['server/vector', 'server/utils'], (Vector, Utils) ->
  Collisions = {}
  
  class Collisions.CircleWithAntiCircle
    constructor: (subject, collider, onCollision=->) ->
      @subject = subject
      @collider = collider
      @collisionCallback = onCollision

    collide: ->
      @onCollision() if @doesCollide()

    collisionNormal: ->
      Vector.scale(-1, Vector.normalize(@separationVector()))

    separationVector: ->
      Vector.subtract(@subject.getPosition(), @collider.getPosition())

    overlapDistance: ->
      Vector.length(@separationVector()) + @subject.getRadius() - @collider.getRadius()

    doesCollide: ->
      @overlapDistance() > 0

    onCollision: ->
      @fixVelocity()
      @fixOverlap()
      @collisionCallback()

    fixVelocity: ->
      normal = @collisionNormal()
      @subject.setVelocity Vector.reflect( @subject.getVelocity(), normal)
      @rotateForRoughness(@collider.getRoughness()) if @collider.getRoughness()

    rotateForRoughness: (roughness) ->
      random = Utils.randomInRange(-1*roughness, roughness)   
      @subject.setVelocity(
        Vector.rotateRad(
          @subject.getVelocity()
          random
        )
      )

    fixOverlap: ->
      normal = @collisionNormal()
      correctionVector = Vector.scale(@overlapDistance(), normal)
      @subject.moveBy correctionVector, true

  class Collisions.CircleWithCircle extends Collisions.CircleWithAntiCircle
    collisionNormal: ->
      Vector.normalize(@separationVector())

    overlapDistance: ->
      @subject.getRadius() + @collider.getRadius() - Vector.length(@separationVector())

  class Collisions.CircleWithAntiArc extends Collisions.CircleWithAntiCircle
    subjectAngle: -> Vector.angleDeg(@separationVector())
    doesCollide: ->
      s = super
      angle = @subjectAngle()
      arcAngles = @collider.getArcAngles()
      super && Utils.angleInRange(angle, arcAngles)
  
  return Collisions

