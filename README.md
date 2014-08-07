# simplifiedavailability
test

> Generates a simple text list of your availability from your Google Calendar


## Development

### Running the server

		$ nodemon -w app app.js

### Testing webhooks on localhost

		$ ultrahook 4372/testhook
		Authenticated as raine
		Forwarding activated...
		http://test.raine.ultrahook.com -> http://localhost:4372/testhook

		$ curl -X POST http://test.raine.ultrahook.com
		[2014-08-07 07:46:34] POST http://localhost:4372/testhook - 200


## Known Issues

### bower install doesn't work in postinstall script
http://stackoverflow.com/questions/20826580/node-js-heroku-deployment-fails-to-exec-postinstall-script-to-install-bower

Current hack is to install public/bower_components locally and don't gitignore them so they get pushed up to the repo.


## Resources

Google API Keys:
https://console.developers.google.com/project/278678249466/apiui/credential?authuser=0

Google API Client Library:
https://developers.google.com/api-client-library/javascript/features/authentication

Google Calendar API:
https://developers.google.com/google-apps/calendar/v3/reference/
https://developers.google.com/google-apps/calendar/v3/reference/events/list

Google API Push Notifications:

* requires HTTPS hook

https://developers.google.com/google-apps/calendar/v3/push
http://stackoverflow.com/questions/19648611/setup-push-notifications-for-google-calendar-api-using-php-client
https://github.com/Server4001/google-cal-event-push-notifications

Angular + Socket.io
https://github.com/btford/angular-socket-io

Using the google-calendar module:
https://github.com/wanasit/google-calendar/blob/master/example/list-example.js

### Webhooks

#### Testing
- [requestb.in](http://requestb.in)
- [respondto.it](http://respondto.it/)
- [ultrahook](http://www.ultrahook.com/) - Receive webhooks on localhost (no https)
- [ngrok](https://ngrok.com/) - Introspected tunnels to localhost (with https)

#### Services
- [webscript.tio](https://www.webscript.io/)
- [pusher.io](http://pusher.com/)
- [Alternatives to Pusher](http://www.quora.com/What-are-alternatives-to-pusher-com)

© [Raine Lourie](https://github.com/metaraine)
