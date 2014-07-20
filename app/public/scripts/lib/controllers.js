(function() {
  angular.module('simpleAvail').factory('socket', [
    'socketFactory', function(socketFactory) {
      return socketFactory();
    }
  ]).controller('TestCtrl', [
    '$scope', 'HourSpan', 'socket', function($scope, HourSpan, socket) {
      $scope.name = 'Raine';
      return socket.on('someEvent', function() {
        return console.log('an event occurred');
      });
    }
  ]);

}).call(this);
