class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    resize! if @count == num_buckets
    unless include?(key)
      self[key] << key
      @count += 1
    end
  end

  def include?(key)
    self[key].include?(key)
  end

  def remove(key)
    deleted = self[key].delete(key)
    @count -= 1 if deleted
  end

  private

  def [](num)
    @store[num.hash % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    doubled = num_buckets * 2
    resized = Array.new(doubled) { Array.new }
    @store.each { |arr| arr.each { |el| resized[el.hash % doubled] << el }}
    @store = resized
  end
end
