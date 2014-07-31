(function() {
  var GoogleStrategy, app, bodyParser, config, express, gcal, indexController, passport, server, session;

  express = require('express');

  session = require('express-session');

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

  app.use(session({
    secret: config.sessionSecret
  }));

  app.use(passport.initialize());

  passport.use(new GoogleStrategy({
    clientID: config.consumerKey,
    clientSecret: config.consumerSecret,
    callbackURL: "http://localhost:" + config.port + "/auth/callback",
    scope: ['openid', 'email', 'https://www.googleapis.com/auth/calendar']
  }, function(accessToken, refreshToken, profile, done) {
    profile.accessToken = accessToken;
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

  indexController(app);

  server = app.listen(config.port, function() {
    var io;
    console.log('Express server listening on port ' + server.address().port);
    io = require('socket.io').listen(server);
    return io.on('connection', function(socket) {
      return console.log('a user connected');
    });
  });

}).call(this);
