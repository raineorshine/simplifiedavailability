# simplifiedavailability

> Generates a simple text list of your availability from your Google Calendar

## Known Issues

### bower install doesn't work in postinstall script
http://stackoverflow.com/questions/20826580/node-js-heroku-deployment-fails-to-exec-postinstall-script-to-install-bower

Current hack is to install public/bower_components locally and don't gitignore them so they get pushed up to the repo.


## Resources

Google API Keys:
https://console.developers.google.com/project/278678249466/apiui/credential?authuser=0

Google Calendar API:
https://developers.google.com/google-apps/calendar/v3/reference/
https://developers.google.com/google-apps/calendar/v3/reference/events/list

Google API Push Notifications:
https://developers.google.com/google-apps/calendar/v3/push
http://stackoverflow.com/questions/19648611/setup-push-notifications-for-google-calendar-api-using-php-client

Angular + Socket.io
https://github.com/btford/angular-socket-io

Using the google-calendar module:
https://github.com/wanasit/google-calendar/blob/master/example/list-example.js


© [Raine Lourie](https://github.com/metaraine)
