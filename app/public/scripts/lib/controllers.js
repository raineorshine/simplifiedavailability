(function() {
  angular.module('simpleAvail').controller('TestCtrl', [
    '$scope', 'HourSpan', function($scope, HourSpan) {
      $scope.name = 'Raine';
      return console.log(HourSpan);
    }
  ]);

}).call(this);
