(function() {
  var simpleAvail;

  simpleAvail = angular.module('simpleAvail', []);

  simpleAvail.controller('TestCtrl', function($scope) {
    return $scope.name = 'Raine';
  });

}).call(this);
