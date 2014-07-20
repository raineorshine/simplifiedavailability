express =         require('express')
session = 				require('express-session')
bodyParser =      require('body-parser')
gcal =            require('google-calendar')
passport =        require('passport')
GoogleStrategy =  require('passport-google-oauth').OAuth2Strategy
config =          require('./config.js')
indexController = require('./controllers/index.js')
require 'newrelic'

# express
app = express()
app.set 'view engine', 'jade'
app.set 'views', __dirname + '/views'
app.use express.static __dirname + '/public'
app.use '/bower', express.static __dirname + '/bower_components'
app.use bodyParser()
app.use session secret: config.sessionSecret
app.use passport.initialize()

# passport
passport.use new GoogleStrategy(
	clientID: 		config.consumerKey
	clientSecret: config.consumerSecret
	callbackURL: 	"http://localhost:#{4372}/auth/callback"
	scope: ['openid', 'email', 'https://www.googleapis.com/auth/calendar']
, (accessToken, refreshToken, profile, done) ->
	profile.accessToken = accessToken
	done null, profile
)

# auth routes
app.get "/auth", passport.authenticate("google",
  session: false
)

app.get "/auth/callback", passport.authenticate("google",
  session: false
  failureRedirect: "/login"
), (req, res) ->
  req.session.access_token = req.user.accessToken
  res.redirect "/"

# main routes
indexController(app)

# start server
server = app.listen config.port, ->
	console.log 'Express server listening on port ' + server.address().port
