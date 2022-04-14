class MaxIntSet
  attr_reader :store

  # max = 4, means 5 numbers [0, 1, 2, 3, 4]
  def initialize(max)
    @store = []
    @max = max
  end

  def insert(num)
    validate!(num)
    @store[num] = true
  end

  def remove(num)
    validate!(num)
    @store.delete_at(num) if include?(num)
  end

  def include?(num)
    validate!(num)
    @store[num] ? true : false
  end

  private

  def is_valid?(num)
    num > -1 && num <= @max
  end

  def validate!(num)
    raise ArgumentError.new('Out of bounds') unless is_valid?(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num] << num
  end

  def remove(num)
    self[num].delete_if { |n| n == num }
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    resize! if @count == num_buckets
    unless include?(num)
      self[num] << num
      @count += 1
    end
  end

  def remove(num)
    deleted = self[num].delete(num)
    @count -= 1 if deleted
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    double_buckets = num_buckets * 2
    resized = Array.new(double_buckets) { Array.new }
    @store.each { |arr| arr.each { |el| resized[el % double_buckets] << el }}
    @store = resized
  end
end
