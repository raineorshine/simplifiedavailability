gcal = require('google-calendar')
google_calendar = new gcal.GoogleCalendar(accessToken)

module.exports = index: (req, res) ->
	res.send 'test'
