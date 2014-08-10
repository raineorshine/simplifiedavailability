(function() {
  var Promise, controller, gcal, request;

  gcal = require('google-calendar');

  Promise = require('bluebird');

  request = require('request-promise');

  controller = function(app) {
    app.get('/', function(req, res) {
      return res.render('index', {
        seed: {
          test: 2
        }
      });
    });
    app.get('/subscribe', function(req, res) {
      var watchRequest;
      if (!req.session.access_token) {
        return res.redirect("/auth");
      }
      watchRequest = request({
        url: 'https://www.googleapis.com/calendar/v3/calendars/raineorshine@gmail.com/events/watch',
        method: 'POST',
        headers: {
          Authorization: 'Bearer ' + req.session.access_token
        },
        json: true,
        body: {
          id: 1234567,
          type: 'web_hook',
          address: 'https://simplifiedavailability.herokuapp.com/calendar-hook'
        }
      });
      watchRequest.then(function(content) {
        console.log('subscribed', content);
        return res.send('subscribed');
      });
      return watchRequest["catch"](function(error) {
        console.log('subscribe error', error.error, error.options);
        return res.send('subscribe error');
      });
    });
    app.all('/calendar-hook', function(req, res) {
      console.log('Calendar webhook received');
      return res.send('calendar-hook');
    });
    app.get('/calendars', function(req, res) {
      var accessToken;
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
      console.log(accessToken);
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
