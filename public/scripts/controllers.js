(function() {
  angular.module('simpleAvail').controller('TestCtrl', [
    '$scope', '$firebase', function($scope, $firebase) {
      var ref, user;
      ref = new Firebase(config.firebaseBase).child('user-12345');
      user = $firebase(ref).$asObject();
      return user.$bindTo($scope, 'user');
    }
  ]);

}).call(this);
