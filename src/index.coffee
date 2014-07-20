express =         require('express')
bodyParser =      require('body-parser')
gcal =            require('google-calendar')
passport =        require('passport')
GoogleStrategy =  require('passport-google-oauth').OAuth2Strategy
config =          require('./config.js')
indexController = require('./controllers/index.js')

require 'newrelic'

app = express()
app.set 'view engine', 'jade'
app.set 'views', __dirname + '/views'
app.use express.static(__dirname + '/public')
app.use bodyParser()
app.use passport.initialize()

passport.use new GoogleStrategy(
	clientID: 		config.consumerKey
	clientSecret: config.consumerSecret
	callbackURL: 	"http://localhost:#{4372}/auth/callback"
	scope: ['openid', 'email', 'https://www.googleapis.com/auth/calendar']
, (accessToken, refreshToken, profile, done) ->

	google_calendar = new gcal.GoogleCalendar(accessToken);
	console.log 'profile', profile
	done null, profile
)

app.get "/auth", passport.authenticate("google",
  session: false
)

app.get "/auth/callback", passport.authenticate("google",
  session: false
  failureRedirect: "/login"
), (req, res) ->
  req.session.access_token = req.user.accessToken
  res.redirect "/"

app.get '/', indexController.index


server = app.listen config.port, ->
	console.log 'Express server listening on port ' + server.address().port
