var express = require('express');
var bodyParser = require('body-parser');
require('newrelic');

var app = express();
app.set('view engine', 'jade');
app.set('views', __dirname + '/views');
app.use(express.static(__dirname + '/public'));
app.use(bodyParser());

app.get('/', function(req, res) {
	res.render('index');
});

var server = app.listen(9342, function() {
	console.log('Express server listening on port ' + server.address().port);
});
