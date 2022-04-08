def range(start, endp)
  return [] if start >= endp
  return [start] if start == (endp - 1)

  [start] + range(start + 1, endp)
end

def sum_recur(arr)
  return 0 if arr.empty?
  return arr.first if arr.length == 1

  arr.first + sum_recur(arr[1..-1])
end

def sum_iter(arr)
  arr.inject { |accu, n| accu + n}
end

def exp(b, n)
  return nil if n < 0
  return 1 if n.zero?

  b * exp(b, n - 1)
end

def exp2(b, n)
  return nil if n.negative?
  return 1 if n.zero?
  return b if n == 1

  if n.even?
    nbr = exp(b, n / 2) 
    nbr * nbr
  else
    nbr = exp(b, (n - 1) / 2)
    b * nbr * nbr
  end
end

def deep_dup(arr)
  deep = []
  arr.each do |ele|
    deep << (ele.is_a?(Array) ? deep_dup(ele) : ele)
  end
  deep
end

def fibonacci_iter(n)
  return nil if n.negative?

  fibo = [0, 1].take(n)
  until fibo.length == n
    fibo << (fibo[-1] + fibo[-2])
  end
  fibo
end

def fibonacci_recur(n)
  return [] if n < 1
  return [0] if n == 1
  return [0, 1] if n == 2

  arr = fibonacci_recur(n - 1) 
  arr << (arr[-1] + arr[-2])
  arr
end

# Target == Middle value? Return
# Target > Middle? Search greater
# Target < Middle? Search lesser
# 4 2, 0 1
# 5, 2 0 1
def bsearch(array, target)
  return nil if array.length.zero?

  half = array.length / 2
  if array[half] == target
    return half
  elsif array[half] > target
    bsearch(array[0...half], target)
  else 
    idx = bsearch(array[(half + 1)..-1], target)
    idx + half + 1 unless idx.nil?
  end
end

def merge(left, right)
  merged = []
  until left.empty? || right.empty? 
    if left.first >= right.first
      merged << right.shift
    else
      merged << left.shift
    end
  end
  merged.concat(right)
  merged.concat(left)
  merged
end

def merge_sort(array)
  return array if array.length < 2

  half = array.length / 2
  left = merge_sort(array[0...half])
  right = merge_sort(array[half..-1])

  merge(left, right)
end

# Observe how it grows
# [] 
# [], [1]
# [], [1], [2], [1, 2]
# Add new number to every previous array
def subsets(arr)
  return [[]] if arr.empty?

  contain = arr[-1] 
  subs = subsets(arr[0...-1])
  sets = deep_dup(subs)
  subs.each do |el|
    sets << (el << contain)
  end
  sets
end

# Just another version by using the same array throughout
def subsets2(arr)
  return [[]] if arr.empty?

  contain = arr[-1] 
  subs = subsets2(arr[0...-1])
  len = subs.length
  (0...len).each do |i|
    subs << (subs[i].dup << contain)
  end
  subs
end

# Observe growth
# [1]
# [1, 2], [2, 1]
# [1, 2, 3], [1, 3, 2], [3, 1, 2], [2, 1, 3], [2, 3, 1], [3, 2, 1]
# Append new number before/after to every spot in the previous arrays
def permutations(array)
  return [[]] if array.empty?
  return [array] if array.length == 1

  ele = array[-1]
  permus = permutations(array[0...-1])
  new_arr = []
  (permus.length).times do |y|
    (permus[y].length + 1).times do |x|
      new_arr << permus[y].dup.insert(x, ele)
    end
  end
  new_arr
end

# Assumes coins are passed from largest -> smallest
def greedy_make_change(amount, coins)
  return [] if amount.zero?
  valid_coins = coins.select { |coin| coin <= amount }
  return nil if valid_coins.empty?

  largest = valid_coins[0]
  greedy_make_change(amount - largest, coins) << largest
end

# Smallest number of coins
def make_change(amount, coins)
  return [] if amount.zero?
  valid_coins = coins.select { |coin| coin <= amount }
  return nil if valid_coins.empty?

  best_solution = nil
  valid_coins.each do |coin|
    solution = make_change(amount - coin, valid_coins)
    solution << coin unless solution.nil?
    best_solution = solution if best_solution.nil? || 
                                best_solution.length > solution.length
  end
  best_solution
end

arr = [1, 2, 3, 4, 5]
p range(1, 5)
p sum_iter(arr)
p sum_recur(arr)
p exp(0, 0)
p exp2(0, 0)
p exp(0, 1)
p exp2(0, 1)
p exp(1, 0)
p exp2(1, 0)
p exp(1, 1)
p exp2(1, 1)
p exp(1, 2)
p exp2(1, 2)
p exp(2, 0)
p exp2(2, 0)
p exp(2, 1)
p exp2(2, 1)
p exp(2, 2)
p exp2(2, 2)
p exp(5, 5)
p exp2(5, 5)
robot_parts = [
  ["nuts", "bolts", "washers"],
  ["capacitors", "resistors", "inductors"]
]
robot_parts_copy = deep_dup(robot_parts)
# shouldn't modify robot_parts
robot_parts_copy[1] << "LEDs"
# but it does
p robot_parts[1] # => ["capacitors", "resistors", "inductors", "LEDs"]

p fibonacci_recur(6)
p fibonacci_iter(6)
p fibonacci_recur(10)
p fibonacci_iter(10)

p bsearch([1, 2, 3], 1) # => 0
p bsearch([2, 3, 4, 5], 3) # => 1
p bsearch([2, 4, 6, 8, 10], 6) # => 2
p bsearch([1, 3, 4, 5, 9], 5) # => 3
p bsearch([1, 2, 3, 4, 5, 6], 6) # => 5
p bsearch([1, 2, 3, 4, 5, 6], 0) # => nil
p bsearch([1, 2, 3, 4, 5, 7], 6) # => nil

arr = [1, 5, 7, 3, 2, 9, 11, 0, 14]
p merge_sort(arr)
p subsets([]) # => [[]]
p subsets([1]) # => [[], [1]]
p subsets([1, 2]) # => [[], [1], [2], [1, 2]]
p subsets([1, 2, 3])
# => [[], [1], [2], [1, 2], [3], [1, 3], [2, 3], [1, 2, 3]]

p subsets2([]) # => [[]]
p subsets2([1]) # => [[], [1]]
p subsets2([1, 2]) # => [[], [1], [2], [1, 2]]
p subsets2([1, 2, 3])
# => [[], [1], [2], [1, 2], [3], [1, 3], [2, 3], [1, 2, 3]]

p [1, 2, 3].permutation.to_a
p [1, 2].permutation.to_a
p [1].permutation.to_a

p permutations([1, 2, 3])
p permutations([1, 2])
p permutations([1])

p greedy_make_change(24, [10, 7, 1])
p make_change(24, [10, 7, 1])