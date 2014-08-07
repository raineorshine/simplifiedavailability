angular.module('simpleAvail')

	.factory 'User', ['$firebase', ($firebase)->
		(username)->
			ref = new Firebase(config.firebaseBase).child(username)
			$firebase(ref).$asObject()
	]

	.factory 'socket', ['socketFactory', (socketFactory)->
		socketFactory()
	]

	.controller 'TestCtrl', ['$scope', 'HourSpan', 'socket', 'User', ($scope, HourSpan, socket, User)->

		socket.on 'someEvent', ()->
			console.log 'an event occurred'

		User('user-12345').$bindTo($scope, 'user')

	]
