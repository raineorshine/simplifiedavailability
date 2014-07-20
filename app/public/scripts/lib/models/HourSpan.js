(function() {
  angular.module('simpleAvail').factory('HourSpan', function() {
    var HourSpan;
    return HourSpan = (function() {
      function HourSpan(start, end) {
        this.start = start;
        this.end = end;
      }

      return HourSpan;

    })();
  });

}).call(this);
