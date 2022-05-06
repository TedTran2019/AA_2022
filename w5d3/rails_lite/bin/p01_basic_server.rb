require 'rack'

PORT = 3000

app = Proc.new do |env|
  req = Rack::Request.new(env)
  res = Rack::Response.new
  res['Content-Type'] = 'text/html'
  path_regex = '^http:\/\/localhost:3000(.*)'
  path = req.url.match(path_regex)
  res.write(path[1])
  res.finish
end

Rack::Server.start(
  app: app,
  Port: PORT
)