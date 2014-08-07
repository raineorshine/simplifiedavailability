gcal =						require('google-calendar')
Promise = 				require('bluebird')
request = 				Promise.promisify(require("request"))

controller = (app)->

	app.get '/', (req, res)->
		res.render 'index',
			seed:
				test: 2

	app.get '/subscribe', (req, res)->

		watchRequest = request
			url: 'https://www.googleapis.com/calendar/v3/calendars/raineorshine@gmail.com/events/watch'
			method: 'POST'
			headers:
				Authorization: 'Bearer: ya29.WgAZywrBbEsW-SIAAABiE6Pg_7qlHpbEaySVopOkPCrR9iEh0tpms-DlqVg6Xo0Srq6HY2U7t4sZGoyOxW8'
			json:
				id: 12345
				type: 'web_hook'
				address: 'http://simplifiedavailability.herokuapp.com/calendar-hook'

		watchRequest.then ()->
			console.log('subscribed')
			res.send('subscribed')

		watchRequest.catch (error)->
			console.log('subscribe error', error)
			res.send('subscribe error')

	app.all '/calendar-hook', (req, res)->
		console.log('Calendar webhook received')
		res.send('calendar-hook')

	app.get '/calendars', (req, res)->
		if !req.session.access_token then return res.redirect("/auth")

		accessToken = req.session.access_token

		gcal(accessToken).calendarList.list (err, data) ->
			if err then return res.send(500, err)
			res.send data

	app.all "/calendars/:calendarId", (req, res) ->
		if !req.session.access_token then return res.redirect("/auth")

		accessToken = req.session.access_token
		calendarId = req.params.calendarId

		console.log accessToken

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
