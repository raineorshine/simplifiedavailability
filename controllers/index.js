var gcal = require('google-calendar');
var google_calendar = new gcal.GoogleCalendar(accessToken);

module.exports = {
	home: function(req, res) {
		res.send('test')
	}
}