def strange_sums(arr)
  dict = {}
  count = 0
  arr.each do |nbr| 
    count += 1 if dict.has_key? nbr
    dict[nbr * -1] = true
  end
  count
end

def pair_product(arr, product)
  dict = {}
  arr.each do |nbr|
    return true if dict.has_key? nbr.to_f
    dict[product.fdiv(nbr)] = true
  end
  false
end

def rampant_repeats(str, hash)
  new_str = ''
  str.each_char { |c| new_str << (hash.key?(c) ? c * hash[c] : c ) }
  new_str
end

def perfect_square(nbr)
  (0..nbr).any? { |n| n * n == nbr } 
end

def divisors(nbr)
  count = 0
  (1..nbr).each { |n| count += 1 if nbr % n == 0 }
  count
end

def anti_prime?(nbr)
  max = divisors(nbr)
  (0...nbr).none? { |n| divisors(n) >= max }
end

def matrix_addition(mat1, mat2)
  new_mat = []
  (0...mat1.length).each do |y|
    sub_arr = []
    (0...mat1[0].length).each do |x|
      sub_arr << mat1[y][x] + mat2[y][x]
    end
    new_mat << sub_arr
  end
  new_mat
end

def factors(nbr)
  (1..nbr).select { |n| nbr % n == 0 }
end

def mutual_factors(*nbrs)
  factors_arr = nbrs.map { |n| factors(n) }
  factors_arr[0].select { |n| factors_arr.all? { |arr| arr.include? n }}
end

def tribonacci_number(nbr)
  return 1 if nbr == 1 || nbr == 2
  return 2 if nbr == 3

  tribonacci_number(nbr - 1) + tribonacci_number(nbr - 2) + tribonacci_number(nbr - 3)
end

def matrix_addition_reloaded(*matrices)
  return nil if matrices.empty? || matrices[0].empty?
  return nil unless matrices.all? { |matrix| (matrix.length == matrices[0].length) && 
                                             matrix.all? { |coors| coors.length == matrix[0].length }}
  new_mat = []
  (0...matrices[0].length).each do |y|
    sub_arr = []
    (0...matrices[0][0].length).each do |x|
      sub_arr << matrices.sum { |matrix| matrix[y][x] }
    end
    new_mat << sub_arr
  end
  new_mat
end

def squarocol?(matrix)
  (0...matrix.length).each do |y|
    sub_arr = []
    return true if matrix[y].uniq.size == 1
    (0...matrix.length).each do |x|
      sub_arr << matrix[x][y]
    end
    return true if sub_arr.uniq.size == 1
  end
  false
end

# [0, 0], [1, 1], [2, 2] - diagonal
# Until # of rows, +1 +1
# [0, 2], [1, 1], [2, 0] - reverse diagonal
# Starting at end of row, +1 -1 
def squaragonal?(matrix)
  diagonal = []
  r_diagonal = []

  (0...matrix.length).each do |coor|
    diagonal << matrix[coor][coor]
  end

  r_diag = [0, matrix.length - 1]
  matrix.length.times do |_|
    r_diagonal << matrix[r_diag[0]][r_diag[1]]
    r_diag[0] += 1
    r_diag[1] -= 1
  end
  r_diagonal.uniq.size == 1 || diagonal.uniq.size == 1
end

def pascals_triangle(n)
  pyramid = []
  n.times do |y|
    sub_arr = []
    (pyramid << [1]) && next if y.zero?
    (0..y).each do |x|
      ele1 = pyramid[y - 1][x]
      ele2 = (x.zero? ? nil : pyramid[y - 1][x - 1])
      ele1 ||= 0
      ele2 ||= 0
      sub_arr << ele1 + ele2
    end
    pyramid << sub_arr
  end
  pyramid
end

# none? returns true with no elements
def prime?(nbr)
  return false if nbr < 2
  (2...nbr).none? { |n| (nbr % n).zero? }
end

# prime_number and follows 2^x + 1 formula
def mersenne_prime(nbr)
  counter = 0
  power = 2
  mersenne = 3
  while nbr
    counter += 1 if prime?(mersenne)
    return mersenne if nbr == counter
    power += 1
    mersenne = (2**power) - 1 
  end
end

def convert(word)
  sum = 0
  word.each_char { |c| sum += (c.ord - 96) }
  sum
end

def triangular_word?(word)
  idx = 1
  nbr = 1
  word_count = convert(word)
  while word_count >= nbr
    return true if word_count == nbr
    idx += 1
    nbr = (idx * (idx + 1)) / 2
  end
  false
end

def consecutive_collapse(numbers)
  collapsed_arr = numbers
  collapsed = false
  until collapsed
    collapsed = true
    i = 0
    arr = []
    while i < collapsed_arr.length
      el1 = collapsed_arr[i]
      el2 = collapsed_arr[i + 1]
      if el2 && (el1 + 1 == el2 || el1 - 1 == el2) && collapsed
        collapsed = false
        i += 2
      else
        arr << collapsed_arr[i]
        i += 1
      end
    end
    collapsed_arr = arr
  end
  collapsed_arr
end

def greater_prime(nbr, away)
  counter = 0
  n = nbr
  while n
    counter += 1 if n > nbr && prime?(n)
    return n if counter == away
    n += 1
  end
end

def lesser_prime(nbr, away)
  primes = []
  (2...nbr).each { |n| primes << n if prime?(n) }
  primes[away]
end

# If arg is positive, replace number w/ closest prime that's greater than it
# If arg is negative, replace number w/ closest prime that's less (or nil if not valid)
def pretentious_primes(arr, n)
  n.negative? ? arr.map { |nbr| lesser_prime(nbr, n)} : arr.map { |nbr| greater_prime(nbr, n)}
end

p strange_sums([2, -3, 3, 4, -2])     # 2
p strange_sums([42, 3, -1, -42])      # 1
p strange_sums([-5, 5])               # 1
p strange_sums([19, 6, -3, -20])      # 0
p strange_sums([9])                   # 0
p pair_product([4, 2, 5, 8], 16)    # true
p pair_product([8, 1, 9, 3], 8)     # true
p pair_product([3, 4], 12)          # true
p pair_product([3, 4, 6, 2, 5], 12) # true
p pair_product([4, 2, 5, 7], 16)    # false
p pair_product([8, 4, 9, 3], 8)     # false
p pair_product([3], 12)             # false
p rampant_repeats('taco', {'a'=>3, 'c'=>2})             # 'taaacco'
p rampant_repeats('feverish', {'e'=>2, 'f'=>4, 's'=>3}) # 'ffffeeveerisssh'
p rampant_repeats('misispi', {'s'=>2, 'p'=>2})          # 'mississppi'
p rampant_repeats('faarm', {'e'=>3, 'a'=>2})            # 'faaaarm'
p perfect_square(1)     # true
p perfect_square(4)     # true
p perfect_square(64)    # true
p perfect_square(100)   # true
p perfect_square(169)   # true
p perfect_square(2)     # false
p perfect_square(40)    # false
p perfect_square(32)    # false
p perfect_square(50)    # false
puts "Anti prime!"
p anti_prime?(24)   # true
p anti_prime?(36)   # true
p anti_prime?(48)   # true
p anti_prime?(360)  # true
p anti_prime?(1260) # true
p anti_prime?(27)   # false
p anti_prime?(5)    # false
p anti_prime?(100)  # false
p anti_prime?(136)  # false
p anti_prime?(1024) # false
matrix_a = [[2,5], [4,7]]
matrix_b = [[9,1], [3,0]]
matrix_c = [[-1,0], [0,-1]]
matrix_d = [[2, -5], [7, 10], [0, 1]]
matrix_e = [[0 , 0], [12, 4], [6,  3]]
p matrix_addition(matrix_a, matrix_b) # [[11, 6], [7, 7]]
p matrix_addition(matrix_a, matrix_c) # [[1, 5], [4, 6]]
p matrix_addition(matrix_b, matrix_c) # [[8, 1], [3, -1]]
p matrix_addition(matrix_d, matrix_e) # [[2, -5], [19, 14], [6, 4]]
puts "Mutual Factors!"
p mutual_factors(50, 30)            # [1, 2, 5, 10]
p mutual_factors(50, 30, 45, 105)   # [1, 5]
p mutual_factors(8, 4)              # [1, 2, 4]
p mutual_factors(8, 4, 10)          # [1, 2]
p mutual_factors(12, 24)            # [1, 2, 3, 4, 6, 12]
p mutual_factors(12, 24, 64)        # [1, 2, 4]
p mutual_factors(22, 44)            # [1, 2, 11, 22]
p mutual_factors(22, 44, 11)        # [1, 11]
p mutual_factors(7)                 # [1, 7]
p mutual_factors(7, 9)              # [1]
p tribonacci_number(1)  # 1
p tribonacci_number(2)  # 1
p tribonacci_number(3)  # 2
p tribonacci_number(4)  # 4
p tribonacci_number(5)  # 7
p tribonacci_number(6)  # 13
p tribonacci_number(7)  # 24
p tribonacci_number(11) # 274
matrix_a = [[2,5], [4,7]]
matrix_b = [[9,1], [3,0]]
matrix_c = [[-1,0], [0,-1]]
matrix_d = [[2, -5], [7, 10], [0, 1]]
matrix_e = [[0 , 0], [12, 4], [6,  3]]
p matrix_addition_reloaded(matrix_a, matrix_b)              # [[11, 6], [7, 7]]
p matrix_addition_reloaded(matrix_a, matrix_b, matrix_c)    # [[10, 6], [7, 6]]
p matrix_addition_reloaded(matrix_e)                        # [[0, 0], [12, 4], [6, 3]]
p matrix_addition_reloaded(matrix_d, matrix_e)              # [[2, -5], [19, 14], [6, 4]]
p matrix_addition_reloaded(matrix_a, matrix_b, matrix_e)    # nil
p matrix_addition_reloaded(matrix_d, matrix_e, matrix_c)    # nil
p squarocol?([
    [:a, :x , :d],
    [:b, :x , :e],
    [:c, :x , :f],
]) # true

p squarocol?([
    [:x, :y, :x],
    [:x, :z, :x],
    [:o, :o, :o],
]) # true

p squarocol?([
    [:o, :x , :o],
    [:x, :o , :x],
    [:o, :x , :o],
]) # false

p squarocol?([
    [1, 2, 2, 7],
    [1, 6, 6, 7],
    [0, 5, 2, 7],
    [4, 2, 9, 7],
]) # true

p squarocol?([
    [1, 2, 2, 7],
    [1, 6, 6, 0],
    [0, 5, 2, 7],
    [4, 2, 9, 7],
]) # false
puts "Squaragonal"
p squaragonal?([
    [:x, :y, :o],
    [:x, :x, :x],
    [:o, :o, :x],
]) # true

p squaragonal?([
    [:x, :y, :o],
    [:x, :o, :x],
    [:o, :o, :x],
]) # true

p squaragonal?([
    [1, 2, 2, 7],
    [1, 1, 6, 7],
    [0, 5, 1, 7],
    [4, 2, 9, 1],
]) # true

p squaragonal?([
    [1, 2, 2, 5],
    [1, 6, 5, 0],
    [0, 2, 2, 7],
    [5, 2, 9, 7],
]) # false
p pascals_triangle(5)
# [
#     [1],
#     [1, 1],
#     [1, 2, 1],
#     [1, 3, 3, 1],
#     [1, 4, 6, 4, 1]
# ]

p pascals_triangle(7)
# [
#     [1],
#     [1, 1],
#     [1, 2, 1],
#     [1, 3, 3, 1],
#     [1, 4, 6, 4, 1],
#     [1, 5, 10, 10, 5, 1],
#     [1, 6, 15, 20, 15, 6, 1]
# ]
p mersenne_prime(1) # 3
p mersenne_prime(2) # 7
p mersenne_prime(3) # 31
p mersenne_prime(4) # 127
p mersenne_prime(6) # 131071
p triangular_word?('abc')       # true
p triangular_word?('ba')        # true
p triangular_word?('lovely')    # true
p triangular_word?('question')  # true
p triangular_word?('aa')        # false
p triangular_word?('cd')        # false
p triangular_word?('cat')       # false
p triangular_word?('sink')      # false
p consecutive_collapse([3, 4, 1])                     # [1]
p consecutive_collapse([1, 4, 3, 7])                  # [1, 7]
p consecutive_collapse([9, 8, 2])                     # [2]
p consecutive_collapse([9, 8, 4, 5, 6])               # [6]
p consecutive_collapse([1, 9, 8, 6, 4, 5, 7, 9, 2])   # [1, 9, 2]
p consecutive_collapse([3, 5, 6, 2, 1])               # [1]
p consecutive_collapse([5, 7, 9, 9])                  # [5, 7, 9, 9]
p consecutive_collapse([13, 11, 12, 12])              # []
p pretentious_primes([4, 15, 7], 1)           # [5, 17, 11]
p pretentious_primes([4, 15, 7], 2)           # [7, 19, 13]
p pretentious_primes([12, 11, 14, 15, 7], 1)  # [13, 13, 17, 17, 11]
p pretentious_primes([12, 11, 14, 15, 7], 3)  # [19, 19, 23, 23, 17]
p pretentious_primes([4, 15, 7], -1)          # [3, 13, 5]
p pretentious_primes([4, 15, 7], -2)          # [2, 11, 3]
p pretentious_primes([2, 11, 21], -1)         # [nil, 7, 19]
p pretentious_primes([32, 5, 11], -3)         # [23, nil, 3]
p pretentious_primes([32, 5, 11], -4)         # [19, nil, 2]
p pretentious_primes([32, 5, 11], -5)         # [17, nil, nil]