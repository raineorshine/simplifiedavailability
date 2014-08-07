config =
	port: process.env.PORT || 4372
	sessionSecret: 'SESSION_SECRET'
	# https://console.developers.google.com/project/278678249466/apiui/credential?authuser=0
	consumerKey: '278678249466-4iq7macj8kot5ln50qnr4ti4gkhnlvlg.apps.googleusercontent.com'
	consumerSecret: '6JOLkdolG-AF2dkW0mSBFDhg'
	firebaseBase: 'https://intense-fire-5360.firebaseio.com'

module.exports = config
