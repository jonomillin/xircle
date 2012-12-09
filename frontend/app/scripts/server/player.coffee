define ['server/world_object', 'server/wraps_world_object', 'server/shapes'], (WorldObject, WrapsWorldObject, Shapes) ->

  player_pieces = [Shapes.Snowman, Shapes.Santa, Shapes.Tree, Shapes.Rudolf, Shapes.Robin, Shapes.Tree]

  class Player
    constructor: (attrs = {}) ->
      @name = attrs.name || "Phil"
      @id = attrs.id
      attrs.shape = player_pieces[ @id % player_pieces.length ]
      @world_object ||= new WorldObject(attrs)
      @score = 0

    lostPoint: ->
      @score = @score - 1

  WrapsWorldObject.mixin(Player)
      
  return Player
