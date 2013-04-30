// Generated by CoffeeScript 1.4.0
(function() {
  var User;

  User = (function() {

    function User(id, options) {
      var k;
      this.id = id;
      if (options == null) {
        options = {};
      }
      for (k in options || {}) {
        this[k] = options[k];
      }
      this['name'] || (this['name'] = this.id);
    }

    return User;

  })();

  module.exports = User;

}).call(this);