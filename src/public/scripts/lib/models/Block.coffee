angular.module('simpleAvail')

	.factory 'Block', ['HourSpan', (HourSpan)->

		class Block extends HourSpan

			constructor: ->
				@freeOrBusy = 'busy'

			@fromEvent = (event)->
				new Block
	]
