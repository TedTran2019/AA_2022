class LRUCache
  def initialize(max)
    @queue = []
    @max = max
  end

  def count
    @queue.size
  end

  def add(el)
    @queue.delete_if { |ele| ele == el }
    @queue << el
    @queue.shift if @queue.count > @max
  end

  def show
    print @queue
  end

  private
  # helper methods go here!

end

johnny_cache = LRUCache.new(4)
johnny_cache.add("I walk the line")
johnny_cache.add(5)
p johnny_cache.count # => returns 2
johnny_cache.add([1,2,3])
johnny_cache.add(5)
johnny_cache.add(-5)
johnny_cache.add({a: 1, b: 2, c: 3})
johnny_cache.add([1,2,3,4])
johnny_cache.add("I walk the line")
johnny_cache.add(:ring_of_fire)
johnny_cache.add("I walk the line")
johnny_cache.add({a: 1, b: 2, c: 3})
johnny_cache.show # => prints [[1, 2, 3, 4], :ring_of_fire, "I walk the line", {:a=>1, :b=>2, :c=>3}]