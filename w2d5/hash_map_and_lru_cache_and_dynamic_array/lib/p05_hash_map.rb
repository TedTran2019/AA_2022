require_relative 'p04_linked_list'

class HashMap
  include Enumerable
  attr_accessor :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket(key).include?(key)
  end

  def set(key, val)
    resize! if @count > num_buckets
    unless bucket(key).update(key, val)
      bucket(key).append(key, val) 
      @count += 1
    end
  end

  def get(key)
    bucket(key).get(key)
  end

  def delete(key)
    @count -= 1 if bucket(key).remove(key)
  end

  def each(&prc)
    @store.each { |link| link.each { |node| prc.call(node.key, node.val) }}
  end

  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    doubled = num_buckets * 2
    resized = Array.new(doubled) { LinkedList.new }
    @store.each do |linked_list|
      linked_list.each { |node| resized[node.key.hash % doubled].append(node.key, node.val) }
    end
    @store = resized
  end

  def bucket(key)
    @store[key.hash % num_buckets]
  end
end
