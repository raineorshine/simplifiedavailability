gcal =						require('google-calendar')

controller = (app)->
	app.get '/', (req, res)->
		res.render 'index',
			seed:
				test: 2

	app.get '/calendars', (req, res)->
		console.log req.session.access_token
		if !req.session.access_token then return res.redirect("/auth")

		accessToken = req.session.access_token

		gcal(accessToken).calendarList.list (err, data) ->
			if err then return res.send(500, err)
			res.send data

	app.all "/calendars/:calendarId", (req, res) ->
		if !req.session.access_token then return res.redirect("/auth")

		accessToken = req.session.access_token
		calendarId = req.params.calendarId

		gcal(accessToken).events.list calendarId,
			maxResults: 10, singleEvents: true, orderBy: 'startTime', timeMin: (new Date).toISOString()#'2014-07-19T00:00:00Z'
		, (err, data) ->

			if err then return res.send(500, err)
			# console.log data

			# if data.nextPageToken
			# 	gcal(accessToken).events.list calendarId,
			# 		maxResults: 1
			# 		pageToken: data.nextPageToken
			# 	,(err, data) ->

			# 		if err then return res.send(500, err)
			# 		# console.log data.items

			res.send data

# app.all "/:calendarId/:eventId", (req, res) ->
#	 return res.redirect("/auth")	unless req.session.access_token

#	 #Create an instance from accessToken
#	 accessToken = req.session.access_token
#	 calendarId = req.params.calendarId
#	 eventId = req.params.eventId
#	 gcal(accessToken).events.get calendarId, eventId, (err, data) ->
#		 return res.send(500, err)	if err
#		 res.send data

#	 return


module.exports = controller
