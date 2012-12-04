define ['shared/micro_event', 'mixins/acts_as_object_group'], (Event, ActsAsObjectGroup) ->

  class GameWorld

  ActsAsObjectGroup.mixin(GameWorld)
  Event.mixin(GameWorld)

  GameWorld
