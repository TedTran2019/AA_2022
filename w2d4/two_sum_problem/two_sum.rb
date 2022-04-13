# Brute force by checking every single pair
def brute_two_sum?(arr, target_sum)
  arr.each_with_index do |n1, y|
    arr.each_with_index do |n2, x|
      next if y == x
      return true if n1 + n2 == target_sum
    end
  end
  false
end

# Sort then bsearch
def sort_two_sum?(arr, target_sum)
  sorted = arr.sort
  sorted.each_with_index do |n, i|
    removed = sorted.delete_at(i)
    return true if binary_search(sorted, target_sum - n)
    sorted.insert(i, removed)
  end
  false
end

def binary_search(arr, target_sum)
  return nil if arr.empty?
  
  half = arr.length / 2
  if arr[half] == target_sum
    return half
  elsif arr[half] > target_sum
    binary_search(arr[0...half], target_sum)
  else
    idx = binary_search(arr[(half + 1)..-1], target_sum)
    idx.nil? ? nil : idx + half + 1
  end
end

def two_sum?(arr, target_sum)
  dict = {}
  arr.each do |el|
    return true if dict.key?(el)
    dict[target_sum - el] = true
  end
  false
end

arr = [0, 1, 5, 7]
p brute_two_sum?(arr, 6) # => should be true
p brute_two_sum?(arr, 10) # => should be false

p sort_two_sum?(arr, 6) # => should be true
p sort_two_sum?(arr, 10) # => should be false

p two_sum?(arr, 6) # => should be true
p two_sum?(arr, 10) # => should be false