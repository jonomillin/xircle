define ->
  class Mixin

  Mixin.mixin	= (destObject) ->
    for own prop,val of @prototype
      console.log prop
      destObject.prototype[prop]	= val

  return Mixin
