angular.module('simpleAvail')

	.controller 'TestCtrl', ['$scope', 'HourSpan', ($scope, HourSpan)->
	  $scope.name = 'Raine'
	  console.log HourSpan
	]
