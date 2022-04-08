# Can also do str ==  str.reverse
def palindrome?(str)
  i = 0
  idx2 = str.length - 1
  while i < (str.length / 2)
    return false unless str[i] == str[idx2]
    i += 1
    idx2 -= 1
  end
  true
end

def substrings(str)
  subs = []
  x = 0
  while x < str.length 
    y = x
    while y < str.length
      subs << str[x..y]
      y += 1
    end
    x += 1
  end
  subs
end

def palindrome_substrings(str)
  substrings(str).select { |substr| substr.length > 1 && palindrome?(substr) }
end