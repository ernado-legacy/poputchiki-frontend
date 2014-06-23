express = require 'express'

server = express()

server.configure ->
  # server.use '/static', express.static(__dirname + '/../static')
  server.use express.static __dirname + '/public'
  server.set 'views', __dirname + '/jade'

server.get '/', (req, res) ->
  # return res.sendfile('/templates/index.html', { root: __dirname + '/..' });
  res.render 'index.jade'

server.listen(5000);