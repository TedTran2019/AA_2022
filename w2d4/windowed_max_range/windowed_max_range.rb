# Naive solution
def windowed_max_range(nbrs, window)
  max_range = nil
  (0...(nbrs.length - (window - 1))).each do |y|
    wdw = nbrs[y...(y + window)]
    current_max = wdw.max - wdw.min
    max_range = current_max if max_range.nil? || current_max > max_range 
  end
  max_range
end

class MyQueue
  def initialize
    @store = []
  end

  def peek
    @store.first
  end

  def size
    @store.size
  end

  def empty?
    @store.empty?
  end

  def enqueue(el)
    @store << el
  end
  
  def dequeue
    @store.shift
  end
end

class MyStack
  def initialize
    @store = []
  end

  def peek
    @store[-1]
  end

  def size
    @store.size
  end

  def empty?
    @store.empty?
  end

  def pop
    @store.pop
  end

  def push(el)
    @store << el
  end
end

class StackQueue
  def initialize
    @stack1 = MyStack.new
    @stack2 = MyStack.new
  end

  def size
    @stack1.size + @stack2.size
  end

  def empty?
    @stack1.empty? && @stack2.empty?
  end

  def enqueue(el)
    @stack1.push(el)
  end

  def dequeue
    @stack2.push(@stack1.pop) until @stack1.empty? if @stack2.empty? 
    @stack2.pop
  end
end

# [element, max, min]
class MinMaxStack
  def initialize
    @store = []
  end

  def peek
    @store[-1][0]
  end

  def size
    @store.size
  end

  def empty?
    @store.empty?
  end

  def max
    return nil if empty?

    @store[-1][1]
  end

  def min
    return nil if empty?

    @store[-1][2]
  end

  def pop
    @store.pop
  end

  def push(el)
    el = el[0] if el.is_a? Array
    if @store.empty?
      @store << [el, el, el]
    else
      max = (el > @store[-1][1] ? el : @store[-1][1])
      min = (el < @store[-1][2] ? el : @store[-1][2])
      @store.push([el, max, min])
    end
  end
end

class MinMaxStackQueue
  def initialize
    @stack1 = MinMaxStack.new
    @stack2 = MinMaxStack.new
  end

  def size
    @stack1.size + @stack2.size
  end

  def empty?
    @stack1.empty? && @stack2.empty?
  end

  def enqueue(el)
    @stack1.push(el)
  end

  def dequeue
    @stack2.push(@stack1.pop) until @stack1.empty? if @stack2.empty? 
    popped = @stack2.pop
    popped[0]
  end

  def max
    return nil if @stack1.empty? && @stack2.empty?
    return @stack1.max if @stack2.empty?
    return @stack2.max if @stack1.empty?
    
    @stack1.max > @stack2.max ? @stack1.max : @stack2.max
  end

  def min
    return nil if @stack1.empty? && @stack2.empty?
    return @stack1.min if @stack2.empty?
    return @stack2.min if @stack1.empty?
    
    @stack1.min < @stack2.min ? @stack1.min : @stack2.min
  end
end

# Better solution
def windowed_max_range_ds(arr, window)  
  queue = MinMaxStackQueue.new
  max_range = nil
  arr.each do |el|
    queue.enqueue(el)
    if queue.size > window
      queue.dequeue 
      curr_max = queue.max - queue.min
      max_range = curr_max if max_range.nil? || curr_max > max_range
    end
  end
  max_range
end

p windowed_max_range([1, 0, 2, 5, 4, 8], 2) == 4 # 4, 8
p windowed_max_range([1, 0, 2, 5, 4, 8], 3) == 5 # 0, 2, 5
p windowed_max_range([1, 0, 2, 5, 4, 8], 4) == 6 # 2, 5, 4, 8
p windowed_max_range([1, 3, 2, 5, 4, 8], 5) == 6 # 3, 2, 5, 4, 8
p windowed_max_range_ds([1, 0, 2, 5, 4, 8], 2) == 4 # 4, 8
p windowed_max_range_ds([1, 0, 2, 5, 4, 8], 3) == 5 # 0, 2, 5
p windowed_max_range_ds([1, 0, 2, 5, 4, 8], 4) == 6 # 2, 5, 4, 8
p windowed_max_range_ds([1, 3, 2, 5, 4, 8], 5) == 6 # 3, 2, 5, 4, 8