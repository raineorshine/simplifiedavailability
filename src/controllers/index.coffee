module.exports =
	index: (req, res)->
		res.render 'index',
			seed:
				test: 2
