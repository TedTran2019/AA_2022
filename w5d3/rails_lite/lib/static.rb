class Static
  attr_reader :app

  def initialize(app)
    @app = app
  end

  def call(env)
    req = Rack::Request.new(env)
    if req.path.match(/^\/public\//)
      full_path = "#{File.dirname(__FILE__)}/..#{req.path}"
      res = Rack::Response.new(env)
      begin
        content = File.read(full_path)
      rescue StandardError => e
        ['404', {'Content-Type' => 'text/plain'}, ['File not found']]
      else
        res['Content-Type'] = Rack::Mime.mime_type(File.extname(full_path))
        res.write(content)
        res.finish
      end
    else
      app.call(env)
    end
  end
end
