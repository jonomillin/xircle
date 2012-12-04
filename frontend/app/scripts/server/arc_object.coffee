define ['server/world_object', 'server/shapes'], (WorldObject, Shapes) ->
  class ArcObject extends WorldObject
    defaultShape: ->
      Shapes.Arc.draw(radius: @radius, arcAngles: @arcAngles, color: @color )

    extractExtraOptions: (options) ->
      @arcAngles = options.arcAngles
