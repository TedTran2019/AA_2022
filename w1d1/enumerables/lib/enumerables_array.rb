class Array
  def my_each(&prc)
    i = 0
    while i < self.length
      prc.call(self[i])
      i += 1
    end
    self
  end

  def my_select(&prc)
    new_arr = []
    self.my_each { |el| new_arr << el if prc.call(el) }
    new_arr
  end

  def my_reject(&prc)
    new_arr = []
    self.my_each { |el| new_arr << el unless prc.call(el) }
    new_arr
  end

  def my_any?(&prc)
    self.my_each { |el| return true if prc.call(el) }
    false
  end

  def my_all?(&prc)
    self.my_each { |el| return false unless prc.call(el) }
    true
  end

  def my_flatten
    flattened = []
    self.each do |el|
      if el.is_a? Array
        flattened.concat(el.my_flatten)
      else
        flattened << el
      end
    end
    flattened
  end

  def my_zip(*args)
    args.unshift(self)
    zipped = []
    (0...self.length).each do |y|
      sub_arr = []
      (0...args.length).each do |x|
        sub_arr << (args[x].nil? ? nil : args[x][y])
      end
      zipped << sub_arr
    end
    zipped
  end

  def neg_rotate(arr, nbr)
    (nbr % arr.length).times { arr.unshift(arr.pop) }
  end

  def pos_rotate(arr, nbr)
    (nbr % arr.length).times { arr << arr.shift }
  end

  def my_rotate(nbr = 1)
    new = self.dup
    nbr.negative? ? neg_rotate(new, nbr * -1) : pos_rotate(new, nbr)
    new
  end
  
  def my_join(sep = '')
    new_str = ''
    self.each.with_index do |str, i|
      new_str << str
      new_str << sep unless i == self.length - 1
    end
    new_str
  end

  def my_reverse
    reversed = []
    self.length.downto(1) { |i| reversed << self[i - 1]}
    reversed
  end
end

def factors(num)
  (1..num).select { |n| (num % n).zero? }
end

class Array
  def bubble_sort!(&prc)
    prc ||= Proc.new { |a, b| a <=> b }
    sorted = false
    until sorted
      sorted = true
      (0...(self.length - 1)).each do |idx|
        res = prc.call(self[idx], self[idx + 1])
        if res == 1
          self[idx], self[idx + 1] = self[idx + 1], self[idx]
          sorted = false
        end
      end
    end
    self
  end

  def bubble_sort(&prc)
    self.dup.bubble_sort!
  end
end

def substrings(string)
  repeat = {}
  substrs = []
  (0...string.length).each do |y|
    (y...string.length).each do |x|
      str = string[y..x]
      (substrs << str) && (repeat[str] = true) unless repeat.key?(str) 
    end
  end
  substrs
end

def subwords(word, dictionary)
  substrings(word).select { |wrd| dictionary.include?(wrd)}
end

a = [1, 2, 3]
p a.my_select { |num| num > 1 } # => [2, 3]
p a.my_select { |num| num == 4 } # => []
a = [1, 2, 3]
p a.my_reject { |num| num > 1 } # => [1]
p a.my_reject { |num| num == 4 } # => [1, 2, 3]
a = [1, 2, 3]
p a.my_any? { |num| num > 1 } # => true
p a.my_any? { |num| num == 4 } # => false
p a.my_all? { |num| num > 1 } # => false
p a.my_all? { |num| num < 4 } # => true
p [1, 2, 3, [4, [5, 6]], [[[7]], 8]].my_flatten # => [1, 2, 3, 4, 5, 6, 7, 8]
a = [ 4, 5, 6 ]
b = [ 7, 8, 9 ]
p [1, 2, 3].my_zip(a, b) # => [[1, 4, 7], [2, 5, 8], [3, 6, 9]]
p a.my_zip([1,2], [8])   # => [[4, 1, 8], [5, 2, nil], [6, nil, nil]]
p [1, 2].my_zip(a, b)    # => [[1, 4, 7], [2, 5, 8]]

c = [10, 11, 12]
d = [13, 14, 15]
p [1, 2].my_zip(a, b, c, d)    # => [[1, 4, 7, 10, 13], [2, 5, 8, 11, 14]]

a = [ "a", "b", "c", "d" ]
p a.my_rotate         #=> ["b", "c", "d", "a"]
p a.my_rotate(2)      #=> ["c", "d", "a", "b"]
p a.my_rotate(-3)     #=> ["b", "c", "d", "a"]
p a.my_rotate(15)     #=> ["d", "a", "b", "c"]

a = [ "a", "b", "c", "d" ]
p a.my_join         # => "abcd"
p a.my_join("$")    # => "a$b$c$d"
p [ "a", "b", "c" ].my_reverse   #=> ["c", "b", "a"]
p [ 1 ].my_reverse               #=> [1]

p factors(0)
p factors(1)
p factors(7)
p factors(6)
p substrings('cat')
