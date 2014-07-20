controller =
	index: (req, res)->
		res.render 'index',
			seed:
				test: 2

module.exports = controller
