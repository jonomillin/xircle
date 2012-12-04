define ['mixins/delegator'], (Delegator) ->

  mixin: (destObject) ->
    destObject.delegate = {
      methods: [
        'moveTo', 'moveBy',
        'setVelocity', 'getVelocity',
        'setPosition', 'getPosition',
        'getRadius',
        'step', 'renderTo'
      ], to: 'world_object'}

    Delegator.mixin(destObject)
