class StaticArray
  attr_reader :store

  def initialize(capacity)
    @store = Array.new(capacity)
  end

  def [](i)
    validate!(i)
    self.store[i]
  end

  def []=(i, val)
    validate!(i)
    self.store[i] = val
  end

  def length
    self.store.length
  end

  private

  def validate!(i)
    raise "Overflow error" unless i.between?(0, self.store.length - 1)
  end
end

class DynamicArray
  include Enumerable
  attr_accessor :count

  def initialize(capacity = 8)
    @store = StaticArray.new(capacity)
    @count = 0
  end

  def [](i)
    i = @count + i if i.negative?
    return nil unless i.between?(0, @store.length - 1)

    @store[i]
  end

  def []=(i, val)
    i = @count + i if i.negative?
    unless i.between?(0, @count - 1)
      while @count < i
        resize! if @count == capacity
        @store[@count] = nil unless @store[@count]
        @count += 1
      end
      @count += 1
    end
    @store[i] = val
  end

  def capacity
    @store.length
  end

  def include?(val)
    i = 0
    while i < @store.length
      return true if @store[i] == val

      i += 1
    end
    false
  end

  def push(val)
    resize! if @count == capacity
    @store[@count] = val
    @count += 1
  end

  def unshift(val)
    resize! if @count == capacity
    i = @count
    while i > 0
      @store[i] = @store[i - 1]
      i -= 1
    end
    @store[0] = val
    @count += 1
  end

  def pop
    return nil if @count.zero?

    val = @store[@count - 1]
    @store[@count - 1] = nil
    @count -= 1
    val
  end

  def shift
    return nil if @count.zero?

    val = first
    i = 1
    while i < @count
      @store[i - 1] = @store[i]
      i += 1
    end
    @count -= 1
    @store[@count] = nil
    val
  end

  def first
    return nil if @count.zero?

    @store[0]
  end

  def last
    return nil if @count.zero?

    @store[@count - 1]
  end

  def each(&prc)
    i = 0
    while i < @count
      prc.call(@store[i])
      i += 1
    end
  end

  def to_s
    "[" + inject([]) { |acc, el| acc << el }.join(", ") + "]"
  end

  def ==(other)
    return false unless [Array, DynamicArray].include?(other.class)
    
    (@count == other.length) && all_same?(other) ? true : false
  end

  alias_method :<<, :push
  [:length, :size].each { |method| alias_method method, :count }

  private

  def resize!
    double = capacity * 2
    resized = StaticArray.new(double)
    self.each_with_index { |el, i| resized[i] = el }
    @store = resized
  end

  def all_same?(other)
    self.each_with_index { |el, i| return false if el != other[i] }
    true
  end
end
