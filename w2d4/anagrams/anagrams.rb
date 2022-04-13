# Checks if str2 is among permutations of str1. Factorial
def first_anagram?(str1, str2)
  permutations = []
  str1.split('').permutation.each { |permu| permutations << permu.join('') }
  permutations.include?(str2)
end

# Deletes letters found in str1 in str2. Quadratic
def second_anagram?(str1, str2)
  str1.each_char do |c|
    idx = str2.index(c)
    return false if idx.nil?

    str2[idx] = ''
  end
  str2.empty?
end

# Sort both strings then compare. nlogn
def third_anagram?(str1, str2)
  str1.split('').sort == str2.split('').sort
end

# Store in hash. n
def fourth_anagram?(str1, str2)
  return false unless str1.length == str2.length

  dict = Hash.new { |h, k| h[k] = 0 }
  (0...str1.length).each do |i|
    dict[str1[i]] += 1
    dict[str2[i]] -= 1
  end
  dict.all? { |_k, v| v.zero? }
end

p first_anagram?("gizmo", "sally")
p first_anagram?("elvis", "lives") 

p second_anagram?("gizmo", "sally")
p second_anagram?("elvis", "lives") 

p third_anagram?("gizmo", "sally")
p third_anagram?("elvis", "lives") 

p fourth_anagram?("gizmo", "sally")
p fourth_anagram?("elvis", "lives") 
