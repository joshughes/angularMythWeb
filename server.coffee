express = require('express')
httpProxy = require('http-proxy')



app = express()
proxy = new httpProxy.RoutingProxy()

proxyOptions = 
	host: '192.168.1.12'
	port: '6544'

exports.startServer = (port, path, callback) ->
	app.use express.static __dirname + '/_public'
	app.get '/Video/*', (req,res) -> 
		console.log("We are doing a request")
		proxy.proxyRequest(req,res,proxyOptions)
	app.get '/Content/*', (req,res) ->
		console.log("We are doing an image request")
		proxy.proxyRequest(req,res,proxyOptions)
	app.get '/Dvr/*', (req,res) ->
		console.log("We are doing an image request")
		proxy.proxyRequest(req,res,proxyOptions)
	app.listen port, ->
		console.log "Express server listening on port %d in %s mode", port


