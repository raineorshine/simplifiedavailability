angular.module('simpleAvail')

	.factory 'socket', ['socketFactory', (socketFactory)->
		socketFactory()
	]

	.controller 'TestCtrl', ['$scope', 'HourSpan', 'socket', '$firebase', ($scope, HourSpan, socket, $firebase)->

		socket.on 'someEvent', ()->
			console.log 'an event occurred'

		testRef = new Firebase(config.firebaseBase + '/test/name')
		testRef.on 'value', (snapshot)->
			console.log snapshot.val()
			$scope.name = snapshot.val()

	]
