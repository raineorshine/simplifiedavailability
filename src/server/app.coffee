express =         require('express')
session = 				require('express-session')
bodyParser =      require('body-parser')
socket = 					require('socket.io')
gcal =            require('google-calendar')
passport =        require('passport')
GoogleStrategy =  require('passport-google-oauth').OAuth2Strategy
config =          require('./config.js')
indexController = require('./controllers/index.js')
require 'newrelic'

# express
app = express()
app.set 'view engine', 'jade'
app.set 'views', __dirname + '/../views'
app.use express.static __dirname + '/../public'
app.use bodyParser.urlencoded extended:false
app.use session
	secret: config.sessionSecret
	saveUninitialized: true
	resave: true
app.use passport.initialize()

# passport
passport.use new GoogleStrategy(
	clientID: 		config.clientId
	clientSecret: config.clientSecret
	callbackURL: 	"http://localhost:#{config.port}/auth/callback"
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

# socket.io server
io = socket.listen(server).on 'connection', (socket)->
  console.log 'a user connected'

