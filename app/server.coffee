express = require('express')
httpProxy = require('http-proxy')

app = express()
proxy = new httpProxy.RoutingProxy()

proxyOptions = 
	host: '192.168.1.12'
	port: '6544'

app.get '/Video/*', (req,res) -> 
	console.log("We are doing a request")
	proxy.proxyRequest(req,res,proxyOptions)

app.listen(3000)


