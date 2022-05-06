require 'json'

class Flash
  def initialize(req)
    @req = req
    @old_flash_storage = req.cookies['_rails_lite_app_flash'].nil? ? {} : JSON.parse(req.cookies['_rails_lite_app_flash'])
    @flash_storage = {}
    @flash_storage[:path] = '/'
    @now_storage = {}
  end

  def [](key)
    @flash_storage[key.to_s] || @old_flash_storage[key.to_s] || now[key.to_s]
  end

  def []=(key, data)
    @flash_storage[key.to_s] = data
  end

  def store_flash(res)
    res.set_cookie('_rails_lite_app_flash', @flash_storage.to_json)
  end

  def now
    @now ||= {}
  end
end
