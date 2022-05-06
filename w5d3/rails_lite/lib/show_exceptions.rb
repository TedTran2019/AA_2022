require 'erb'

class ShowExceptions
  attr_reader :app

  def initialize(app)
    @app = app
  end

  def call(env)
    begin
      app.call(env)
    rescue StandardError => e
      ['500', {'Content-type' => 'text/html'}, [render_exception(e)]]
    end
  end

  private

  def render_exception(e)
    e.message
  end
end
