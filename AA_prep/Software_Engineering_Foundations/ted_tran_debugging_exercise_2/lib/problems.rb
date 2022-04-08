# Run `bundle exec rspec` and satisy the specs.
# You should implement your methods in this file.
# Feel free to use the debugger when you get stuck.
require 'byebug'

def is_prime?(nbr)
  return false if nbr < 2
  (2...nbr).each do |factor|
    return false if (nbr % factor).zero?
  end
  true
end

def largest_prime_factor(nbr)
  nbr.downto(2) do |i|
    return i if nbr % i == 0 && is_prime?(i)
  end
  nil
end

def unique_chars?(str)
  dict = Hash.new(0)
  str.downcase.each_char { |c| dict[c] += 1}
  dict.values.none? { |v| v > 1 }
end

def dupe_indices(arr)
  dict = Hash.new { |h, k| h[k] = [] }
  arr.each_with_index { |ele, i| dict[ele] << i }
  dict.select { |k, v| v.length > 1 }
end

def ana_array(arr1, arr2)
  return false unless arr1.length == arr2.length 
  dict = Hash.new(0)
  (0...(arr1.length)).count do |i| 
    dict[arr1[i]] += 1
    dict[arr2[i]] -= 1
  end
  dict.values.all? { |v| v.zero? }
end