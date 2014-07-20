(function() {
  var GoogleStrategy, app, bodyParser, config, express, gcal, indexController, passport, server;

  express = require('express');

  bodyParser = require('body-parser');

  gcal = require('google-calendar');

  passport = require('passport');

  GoogleStrategy = require('passport-google-oauth').OAuth2Strategy;

  config = require('./config.js');

  indexController = require('./controllers/index.js');

  require('newrelic');

  app = express();

  app.set('view engine', 'jade');

  app.set('views', __dirname + '/views');

  app.use(express["static"](__dirname + '/public'));

  app.use(bodyParser());

  app.use(passport.initialize());

  passport.use(new GoogleStrategy({
    clientID: config.consumerKey,
    clientSecret: config.consumerSecret,
    callbackURL: "http://localhost:" + 4372 + "/auth/callback",
    scope: ['openid', 'email', 'https://www.googleapis.com/auth/calendar']
  }, function(accessToken, refreshToken, profile, done) {
    var google_calendar;
    google_calendar = new gcal.GoogleCalendar(accessToken);
    console.log('profile', profile);
    return done(null, profile);
  }));

  app.get("/auth", passport.authenticate("google", {
    session: false
  }));

  app.get("/auth/callback", passport.authenticate("google", {
    session: false,
    failureRedirect: "/login"
  }), function(req, res) {
    req.session.access_token = req.user.accessToken;
    return res.redirect("/");
  });

  app.get('/', indexController.index);

  server = app.listen(config.port, function() {
    return console.log('Express server listening on port ' + server.address().port);
  });

}).call(this);
