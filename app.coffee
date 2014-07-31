express = require 'express'

server = express()

server.configure ->
  # server.use '/static', express.static(__dirname + '/../static')
  server.use express.static __dirname + '/public'
  server.set 'views', __dirname + '/jade'

index = (req, res) ->
  res.render 'index.jade'

server.get '/', index
server.get '/login/', index
server.get '/register/', index
server.get '/profile/', index
server.get '/message/', index
server.get '/message/:id', index
server.get '/user/:id', index
server.get '/statuses/', index
server.get '/favourites/', index
server.get '/guests/', index
server.get '/search/', index
server.get '/settings/', index



server.listen(5000)