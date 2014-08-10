config =
	port: process.env.PORT || 4372
	sessionSecret: 'SESSION_SECRET'
	# https://console.developers.google.com/project/apps~simplifiedavailability/apiui/credential?authuser=0
	clientId: '701202081631-1tirpvd5kssq0h98bpdrjg6lgdke6h66.apps.googleusercontent.com'
	clientSecret: '2ySIqGjwhMbeALTOw_KB7meZ'
	firebaseUrl: 'https://intense-fire-5360.firebaseio.com'

module.exports = config
