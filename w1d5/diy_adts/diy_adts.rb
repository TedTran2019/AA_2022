class Stack
  def initialize
    @stack = []
  end

  def push(el)
    @stack << el
  end

  def pop
    @stack.pop
  end

  def peek
    @stack[-1]
  end
end

class Queue
  def initialize
    @queue = []
  end

  def enqueue(el)
    @queue << el
  end

  def dequeue
    @queue.shift
  end

  def peek
    @queue[0]
  end
end

# Naive map implemented with array
class Map
  def initialize
    @map = []
  end

  def set(k, v)
    idx = key_idx(k)
    if idx
      @map[idx][1] = v
    else
      @map << [k, v]
    end
  end

  def get(key)
    @map.each { |kv| return kv[1] if kv[0] == key }
    nil
  end

  def delete(key)
    @map.delete_if { |kv| kv[0] == key }
  end

  def show
    print '{'
    @map.each_with_index do |kv, i|
      print "#{kv[0]}=>#{kv[1]}"
      print ', ' unless i == (@map.length - 1)
    end
    print '}'
    puts "\n"
  end

  def key_idx(key)
    @map.each_with_index { |kv, i| return i if kv[0] == key }
    nil
  end
end