(function() {
  angular.module('simpleAvail').factory('socket', [
    'socketFactory', function(socketFactory) {
      return socketFactory();
    }
  ]).controller('TestCtrl', [
    '$scope', 'HourSpan', 'socket', '$firebase', function($scope, HourSpan, socket, $firebase) {
      var testRef;
      socket.on('someEvent', function() {
        return console.log('an event occurred');
      });
      testRef = new Firebase(config.firebaseBase + '/test/name');
      return testRef.on('value', function(snapshot) {
        console.log(snapshot.val());
        return $scope.name = snapshot.val();
      });
    }
  ]);

}).call(this);
