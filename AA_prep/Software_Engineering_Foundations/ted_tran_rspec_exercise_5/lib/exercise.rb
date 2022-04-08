def zip(*arrs)
  new_arr = []
  (0...(arrs[0].length)).each do |y|
    sub_arr = []
    (0...arrs.length).each do |x|
      sub_arr << arrs[x][y]
    end
    new_arr << sub_arr
  end
  new_arr
end

def prizz_proc(arr, prc1, prc2)
  arr.select { |el| prc1.call(el) ^ prc2.call(el) }
end

def zany_zip(*arrs)
  new_arr = []
  max = arrs.inject(0) { |accu, arr| arr.length > accu ? arr.length : accu }
  (0...max).each do |y|
    sub_arr = []
    (0...arrs.length).each do |x|
      sub_arr << arrs[x][y]
    end
    new_arr << sub_arr
  end
  new_arr
end

def maximum(arr, &prc)
  arr.inject { |accu, n| prc.call(n) >= prc.call(accu) ? n : accu }
end

def my_group_by(arr, &prc)
  hash = Hash.new { |h, k| h[k] = [] }
  arr.each { |el| hash[prc.call(el)] << el}
  hash
end

def max_tie_breaker(arr, prc1, &prc2)
  return nil if arr.empty?

  largest = arr.first
  largest_count = prc2.call(arr.first)
  (1...arr.length).each do |idx|
    amount = prc2.call(arr[idx])
    if amount > largest_count || ((amount == largest_count) && (prc1.call(arr[idx]) > prc1.call(largest)))
      largest = arr[idx]
      largest_count = amount
    end
  end
  largest
end

def silly_syllable(str)
  vowels = 'aeiou'
  return str if str.count('aeiou') < 2
  new_str = str[str.index(/[aeiou]/)..-1]
  last_vowel_idx = nil
  new_str.each_char.with_index { |c, i| last_vowel_idx = i if vowels.include? c }
  new_str[0..last_vowel_idx]
end

def silly_syllables(str)
  str.split(' ').map { |word| silly_syllable(word) }.join(' ')
end