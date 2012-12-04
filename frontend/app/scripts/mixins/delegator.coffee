define ->
  class Delegator

  Delegator.mixin = (destObject) ->
    to = destObject.delegate.to
    for method in destObject.delegate.methods
      do (method) ->
        destObject.prototype[method] ||= (args...) ->
          @[to][method](args...)

  return Delegator
