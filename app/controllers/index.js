(function() {
  var controller, gcal;

  gcal = require('google-calendar');

  controller = function(app) {
    app.get('/', function(req, res) {
      return res.render('index', {
        seed: {
          test: 2
        }
      });
    });
    app.get('/calendars', function(req, res) {
      var accessToken;
      console.log(req.session.access_token);
      if (!req.session.access_token) {
        return res.redirect("/auth");
      }
      accessToken = req.session.access_token;
      return gcal(accessToken).calendarList.list(function(err, data) {
        if (err) {
          return res.send(500, err);
        }
        return res.send(data);
      });
    });
    return app.all("/calendars/:calendarId", function(req, res) {
      var accessToken, calendarId;
      if (!req.session.access_token) {
        return res.redirect("/auth");
      }
      accessToken = req.session.access_token;
      calendarId = req.params.calendarId;
      return gcal(accessToken).events.list(calendarId, {
        maxResults: 10,
        singleEvents: true,
        orderBy: 'startTime',
        timeMin: (new Date).toISOString()
      }, function(err, data) {
        if (err) {
          return res.send(500, err);
        }
        return res.send(data);
      });
    });
  };

  module.exports = controller;

}).call(this);
