def element_count(arr)
  dict = Hash.new { |h, k| h[k] = 0 }
  arr.each { |el| dict[el] += 1 }
  dict
end

def char_replace!(str, hash)
  str.each_char.with_index { |c, i| str[i] = hash[c] if hash.has_key? c }
end

def product_inject(arr)
  arr.inject { |accu, n| accu * n }
end