define ['server/world_object', 'server/shapes'], (WorldObject, Shapes) ->
  class ArcObject extends WorldObject
    defaultShape: -> Shapes.Arc
    shapeAttributes: ->
      {radius: @radius, arcAngles: @arcAngles, color: @color }

    extractExtraOptions: (options) ->
      @arcAngles = options.arcAngles

    getArcAngles: -> @arcAngles
