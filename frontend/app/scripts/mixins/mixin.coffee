define ->
  class Mixin

  Mixin.mixin	= (destObject) ->
    for own prop,val of @prototype
      destObject.prototype[prop]	= val

  return Mixin
