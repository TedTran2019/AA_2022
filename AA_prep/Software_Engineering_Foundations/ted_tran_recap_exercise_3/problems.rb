def no_dupes?(arr)
  dict = Hash.new { |h, k| h[k] = 0 }
  arr.each { |el| dict[el] += 1 }
  dict.select { |k, v| v == 1}.keys
end

def no_consecutive_repeats?(arr)
  (0...(arr.length - 1)).each { |i| return false if arr[i] == arr[i + 1] }
  true
end

def char_indices(str)
  dict = Hash.new { |h, k| h[k] = [] }
  str.each_char.with_index { |c, i| dict[c] << i }
  dict
end

def longest_streak(str)
  longest_str = ''
  longest_len = 0
  new_str = ''
  (0...str.length).each do |i|
    new_str << str[i]
    if str[i] != str[i + 1]
      if new_str.length >= longest_len
        longest_str = new_str
        longest_len = new_str.length
      end
      new_str = ''
    end
  end
  longest_str
end

def prime?(n)
  return false if n < 2
  (2...n).each { |nbr| return false if (n % nbr).zero? }
  true
end

def bi_prime?(n)
  (2...n).each do |f1|
    next unless prime?(f1)
    (f1...n).each do |f2|
      next unless prime?(f2)
      return true if f1 * f2 == n
    end
  end
  false
end

def vigenere_cipher(str, arr)
  cipher_str = ''
  str.each_char.with_index do |c, i|
    cipher_str << ((c.ord + arr[i % arr.length]) % 97 % 26 + 97).chr
  end
  cipher_str
end

def vowel_rotate(str)
  vowels = 'aeiou'
  prev_vowel = nil
  first = true
  first_vowel_idx = nil
  str.each_char.with_index do |c, i|
    if vowels.include?(c)
      if first
        prev_vowel = c
        first = false 
        first_vowel_idx = i
      else
        str[i], prev_vowel = prev_vowel, str[i]
      end
    end
  end
  str[first_vowel_idx] = prev_vowel
  str
end

class String
  def select(&prc)
    new_str = ''
    return new_str if prc.nil?
    self.each_char { |c| new_str << c if prc.call(c) }
    new_str
  end

  def map!(&prc)
    self.each_char.with_index { |c, i| self[i] = prc.call(c, i) }
    self
  end
end

def multiply(a, b)
  flag = 1
  (flag *= -1) && (a *= -1) if a.negative?
  (flag *= -1) && (b *= -1) if b.negative?
  return a if b == 1
  return 0 if b.zero?

  (a + multiply(a, b - 1)) * flag
end

def lucas_sequence(len)
  return [] if len.zero? 
  return [2] if len == 1
  return [2, 1] if len == 2

  arr = lucas_sequence(len - 1)
  arr << (arr[-1] + arr[-2])
  arr
end

def prime?(nbr)
  return false if nbr < 2
  (2...nbr).none? { |n| (nbr % n).zero? }
end

def prime_factorization(nbr)
  primes = []
  (2...nbr).each do |n|
    if (nbr % n).zero? && prime?(n)
      primes.concat(prime_factorization(n))
      primes.concat(prime_factorization(nbr / n))
      break
    end
  end
  primes << nbr if primes.empty?
  primes
end

print no_dupes?([1, 1, 2, 1, 3, 2, 4])         # => [3, 4]
print no_dupes?(['x', 'x', 'y', 'z', 'z'])     # => ['y']
print no_dupes?([true, true, true])            # => []
puts ""
puts no_consecutive_repeats?(['cat', 'dog', 'mouse', 'dog'])     # => true
puts no_consecutive_repeats?(['cat', 'dog', 'dog', 'mouse'])     # => false
puts no_consecutive_repeats?([10, 42, 3, 7, 10, 3])              # => true
puts no_consecutive_repeats?([10, 42, 3, 3, 10, 3])              # => false
puts no_consecutive_repeats?(['x'])                              # => true
puts char_indices('mississippi')   # => {"m"=>[0], "i"=>[1, 4, 7, 10], "s"=>[2, 3, 5, 6], "p"=>[8, 9]}
puts char_indices('classroom')     # => {"c"=>[0], "l"=>[1], "a"=>[2], "s"=>[3, 4], "r"=>[5], "o"=>[6, 7], "m"=>[8]}
puts longest_streak('a')           # => 'a'
puts longest_streak('accccbbb')    # => 'cccc'
puts longest_streak('aaaxyyyyyzz') # => 'yyyyy
puts longest_streak('aaabbb')      # => 'bbb'
puts longest_streak('abc')         # => 'c'
puts bi_prime?(14)   # => true
puts bi_prime?(22)   # => true
puts bi_prime?(25)   # => true
puts bi_prime?(94)   # => true
puts bi_prime?(24)   # => false
puts bi_prime?(64)   # => false
puts vigenere_cipher("toerrishuman", [1])        # => "upfssjtivnbo"
puts vigenere_cipher("toerrishuman", [1, 2])     # => "uqftsktjvobp"
puts vigenere_cipher("toerrishuman", [1, 2, 3])  # => "uqhstltjxncq"
puts vigenere_cipher("zebra", [3, 0])            # => "ceerd"
puts vigenere_cipher("yawn", [5, 1])             # => "dbbo"
puts vowel_rotate('computer')      # => "cempotur"
puts vowel_rotate('oranges')       # => "erongas"
puts vowel_rotate('headphones')    # => "heedphanos"
puts vowel_rotate('bootcamp')      # => "baotcomp"
puts vowel_rotate('awesome')       # => "ewasemo"
puts "app academy".select { |ch| !"aeiou".include?(ch) }   # => "pp cdmy"
puts "HELLOworld".select { |ch| ch == ch.upcase }          # => "HELLO"
puts "HELLOworld".select          # => ""
word_1 = "Lovelace"
word_1.map! do |ch| 
    if ch == 'e'
        '3'
    elsif ch == 'a'
        '4'
    else
        ch
    end
end
puts word_1        # => "Lov3l4c3"

word_2 = "Dijkstra"
word_2.map! do |ch, i|
    if i.even?
        ch.upcase
    else
        ch.downcase
    end
end
puts word_2        # => "DiJkStRa"
puts multiply(3, 5)        # => 15
puts multiply(5, 3)        # => 15
puts multiply(2, 4)        # => 8
puts multiply(0, 10)       # => 0
puts multiply(-3, -6)      # => 18
puts multiply(3, -6)       # => -18
puts multiply(-3, 6)       # => -18
print lucas_sequence(0)   # => []
print lucas_sequence(1)   # => [2]    
print lucas_sequence(2)   # => [2, 1]
print lucas_sequence(3)   # => [2, 1, 3]
print lucas_sequence(6)   # => [2, 1, 3, 4, 7, 11]
print lucas_sequence(8)   # => [2, 1, 3, 4, 7, 11, 18, 29]
puts "\nNext problem!"
print prime_factorization(12)     # => [2, 2, 3]
print prime_factorization(24)     # => [2, 2, 2, 3]
print prime_factorization(25)     # => [5, 5]
print prime_factorization(60)     # => [2, 2, 3, 5]
print prime_factorization(7)      # => [7]
print prime_factorization(11)     # => [11]
print prime_factorization(2017)   # => [2017]
puts "\nNext problem!"
puts prime?(1)
puts prime?(2)
puts prime?(3)