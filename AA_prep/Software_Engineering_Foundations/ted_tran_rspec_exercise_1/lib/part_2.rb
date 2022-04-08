def hipsterfy(word)
  vowels = 'aeiou'
  i = word.length - 1
  i.downto(0) do |idx|
    if vowels.include? word[idx]
      word[idx] = ''
      break
    end
  end
  word
end

def vowel_counts(str)
  vowels = {
    'a' => 0,
    'e' => 0,
    'i' => 0, 
    'o' => 0, 
    'u' => 0
  }

  str.downcase.each_char { |char| vowels[char] += 1 if vowels.key? char }
  vowels
end

def caesar_cipher(message, n)
  cipher = ''
  message.each_char do |char|
    uni = char.ord
    if uni.between?(97, 122)
      cipher << (uni + n) % 97 % 26 + 97
    elsif uni.between?(65, 90)
      cipher << (uni + n) % 65 % 26 + 65
    else
      cipher << char
    end
  end
  cipher
end