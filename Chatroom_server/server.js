var express = require("express");
var path = require("path");
var app = express();
var bodyParser = require('body-parser');
app.use(express.static(path.join(__dirname, "./static")));
app.use(bodyParser.urlencoded());
app.set('views', path.join(__dirname, './views'));
app.set('view engine', 'ejs');
app.get('/', function(req, res) {
 res.render("index");
});
var server = app.listen(8000, function() {
 console.log("listening on port 6789");
});
var io = require('socket.io').listen(server);
io.sockets.on('connection', function (socket) {
  console.log("SERVER::WE ARE USING SOCKETS!");
  console.log(socket.id);

  socket.on('messageToServer', function(data){
  	console.log('messsagetoServer data', data)
  	io.sockets.emit('messageFromServer', data);
  })
});