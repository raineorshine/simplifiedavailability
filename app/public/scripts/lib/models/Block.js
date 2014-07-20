(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  angular.module('simpleAvail').factory('Block', [
    'HourSpan', function(HourSpan) {
      var Block;
      return Block = (function(_super) {
        __extends(Block, _super);

        function Block() {
          this.freeOrBusy = 'busy';
        }

        Block.fromEvent = function(event) {
          return new Block;
        };

        return Block;

      })(HourSpan);
    }
  ]);

}).call(this);
