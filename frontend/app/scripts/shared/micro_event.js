define(function() {
  var MicroEvent	= function(){}
  MicroEvent.prototype	= {
    on	: function(event, fct){
      this._events = this._events || {};
      this._events[event] = this._events[event]	|| [];
      this._events[event].push(fct);
    },
    off	: function(event, fct){
      this._events = this._events || {};
      if( event in this._events === false  )	return;
      this._events[event].splice(this._events[event].indexOf(fct), 1);
    },
    emit	: function(event /* , args... */){
      this._events = this._events || {};
      if( event in this._events === false  )	return;
      for(var i = 0; i < this._events[event].length; i++){
        this._events[event][i].apply(this, Array.prototype.slice.call(arguments, 1))
      }
    }
  };

  /**
   * mixin will delegate all MicroEvent.js function in the destination object
   *
   * - require('MicroEvent').mixin(Foobar) will make Foobar able to use MicroEvent
   *
   * @param {Object} the object which will support MicroEvent
  */
  MicroEvent.mixin	= function(destObject){
    var props	= ['on', 'off', 'emit'];
    for(var i = 0; i < props.length; i ++){
      destObject.prototype[props[i]]	= MicroEvent.prototype[props[i]];
    }
  }

  return MicroEvent
});
