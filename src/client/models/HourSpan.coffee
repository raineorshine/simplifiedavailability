angular.module('simpleAvail')

	.factory 'HourSpan', ->

		class HourSpan
			constructor: (@start, @end)->
