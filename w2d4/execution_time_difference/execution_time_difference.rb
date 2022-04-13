def my_min(list)
  return list.first if list.length < 2
  smallest = list.first
  list.each { |el| smallest = el if el < smallest }
  smallest
end

# Slow solution
def largest_contiguous_subsum(list)
  sums = []
  list.each_with_index do |_n, y|
    (y...list.length).each do |x|
      sums <<  list[y..x].sum
    end
  end
  sums.max
end

# Fast solution
def largest_contiguous_subsum2(list)
  return list.first if list.length < 2

  largest_sum = list.first
  current_sum = list.first
  list[1..-1].each do |n|
    current_sum += n
    current_sum = n if current_sum.negative? || n > current_sum
    largest_sum = current_sum if current_sum > largest_sum
  end
  largest_sum
end

list = [ 0, 3, 5, 4, -5, 10, 1, 90 ]
p my_min(list)  # =>  -5
list = [5, 3, -7]
p largest_contiguous_subsum(list) # => 8
p largest_contiguous_subsum2(list) 
list = [2, 3, -6, 7, -6, 7]
p largest_contiguous_subsum(list)
p largest_contiguous_subsum2(list) 
 list = [-5, -1, -3]
p largest_contiguous_subsum(list)
p largest_contiguous_subsum2(list) 




