def select_even_nums(arr)
  arr.select { |nbr| nbr.even? }
end

def reject_puppies(arr)
  arr.reject { |hash| hash["age"] <= 2}
end

def count_positive_subarrays(arr)
  arr.count { |sub_arr| sub_arr.sum > 0}
end

def aba_translate(str)
  vowels = 'aeiou'
  aba_str = ''
  str.each_char { |c| aba_str << (vowels.include?(c) ? "#{c}b#{c}" : c) }
  aba_str
end

def aba_array(arr)
  arr.map { |str| aba_translate(str) }
end
