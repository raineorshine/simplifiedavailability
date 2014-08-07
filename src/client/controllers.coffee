angular.module('simpleAvail')

	.controller 'TestCtrl', ['$scope', '$firebase', ($scope, $firebase)->

		ref = new Firebase(config.firebaseBase).child('user-12345')
		user = $firebase(ref).$asObject()
		user.$bindTo($scope, 'user')

	]
