(function() {
  angular.module('simpleAvail').factory('User', [
    '$firebase', function($firebase) {
      return function(username) {
        var ref;
        ref = new Firebase(config.firebaseUrl).child(username);
        return $firebase(ref).$asObject();
      };
    }
  ]).factory('socket', [
    'socketFactory', function(socketFactory) {
      return socketFactory();
    }
  ]).controller('TestCtrl', [
    '$scope', 'HourSpan', 'socket', 'User', function($scope, HourSpan, socket, User) {
      socket.on('someEvent', function() {
        return console.log('an event occurred');
      });
      return User('user-12345').$bindTo($scope, 'user');
    }
  ]);

}).call(this);
