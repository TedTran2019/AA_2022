require 'active_support'
require 'active_support/core_ext'
require 'erb'
require_relative './session'
require 'active_support/inflector'
require 'byebug'
class ControllerBase
  attr_reader :req, :res, :params

  # Setup the controller
  def initialize(req, res, params = nil)
    @req = req
    @res = res
    @already_built_response = false
    @params = params || {}
    @params.merge!(req.params)
  end

  def self.protect_from_forgery
    @@protect_from_forgery = true
  end

  def check_authenticity_token
    raise "Invalid authenticity token" unless @token == params['authenticity_token']
  end

  def form_authenticity_token
    create_token unless @token
    @res.set_cookie('authenticity_token', @token)
    @token
  end

  # Helper method to alias @already_built_response
  def already_built_response?
    @already_built_response
  end

  # Set the response status code and header
  def redirect_to(url)
    raise "Can't redirect and render" if already_built_response?

    session.store_session(res)
    res['Location'] = url
    res.status = 302
    @already_built_response = true
  end

  # Populate the response with content.
  # Set the response's content type to the given type.
  # Raise an error if the developer tries to double render.
  def render_content(content, content_type)
    raise "Can't render twice" if already_built_response?

    session.store_session(res)
    res['Content-Type'] = content_type
    res.write(content)
    @already_built_response = true
  end

  # use ERB and binding to evaluate templates
  # pass the rendered html to render_content
  def render(template_name)
    controller_name = self.class.to_s.underscore
    path = "views/#{controller_name}/#{template_name}.html.erb"
    full_path = "#{File.dirname(__FILE__)}/../#{path}"
    template = ERB.new(File.read(full_path)).result(binding)
    render_content(template, 'text/html')
  end

  # method exposing a `Session` object
  def session
    @session ||= Session.new(@req)
  end

  # use this with the router to call action_name (:index, :show, :create...)
  def invoke_action(name)
    create_token unless @token
    check_authenticity_token if @req.request_method != 'GET' && @@protect_from_forgery
    self.send(name)
    render(name) unless already_built_response?
  end

  private

  def create_token
    cookie = @req.cookies['authenticity_token']
    @token = cookie.nil? ? SecureRandom.urlsafe_base64(16) : cookie
  end
end

