angular.module('simpleAvail')

	.factory 'socket', ['socketFactory', (socketFactory)->
	  socketFactory()
	]

	.controller 'TestCtrl', ['$scope', 'HourSpan', 'socket', ($scope, HourSpan, socket)->
	  $scope.name = 'Raine'

	  socket.on 'someEvent', ()->
	  	console.log 'an event occurred'
	]
