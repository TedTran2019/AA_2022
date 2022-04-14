class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    @prev.next = @next
    @next.prev = @prev
  end
end

class LinkedList
  include Enumerable

  def initialize
    @head = Node.new 
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next == @tail ? nil : @head.next
  end

  def last
    @tail.prev == @head ? nil : @tail.prev
  end

  def empty?
    @head.next.next.nil?
  end

  def get(key)
    self.each { |link| return link.val if link.key == key }
    nil
  end

  def include?(key)
    self.each { |link| return true if link.key == key }
    false
  end

  def append(key, val)
    prev_last_node = @tail.prev
    last_node = Node.new(key, val)
    prev_last_node.next = last_node
    last_node.prev = prev_last_node
    last_node.next = @tail
    @tail.prev = last_node
  end

  def update(key, val)
    self.each do |link|
      if link.key == key
        link.val = val
        return true
      end
    end
    false
  end

  def remove(key)
    self.each do |link|
      if link.key == key
        link.remove
        return true
      end
    end
    false
  end

  def each(&prc)
    first_node = @head.next
    until first_node.next.nil?
      prc.call(first_node)
      first_node = first_node.next
    end
  end

  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
