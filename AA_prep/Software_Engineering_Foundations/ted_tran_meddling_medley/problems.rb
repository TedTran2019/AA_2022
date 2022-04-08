def duos(str)
  count = 0
  (0...(str.length - 1)).each do |i|
    count += 1 if str[i] == str[i + 1]
  end
  count
end

p duos('bootcamp')      # 1
p duos('wxxyzz')        # 2
p duos('hoooraay')      # 3
p duos('dinosaurs')     # 0
p duos('e')             # 0

def sentence_swap(sentence, hash)
  sentence.split(' ').map { | word| hash.key?(word) ? hash[word] : word }.join(' ')
end

p sentence_swap('anything you can do I can do',
    'anything'=>'nothing', 'do'=>'drink', 'can'=>'shall'
) # 'nothing you shall drink I shall drink'

p sentence_swap('what a sad ad',
    'cat'=>'dog', 'sad'=>'happy', 'what'=>'make'
) # 'make a happy ad'

p sentence_swap('keep coding okay',
    'coding'=>'running', 'kay'=>'pen'
) # 'keep running okay'

def hash_mapped(hash, prc1, &prc2)
  new_hash = {}
  hash.each { |k, v| new_hash[prc2.call(k)] = prc1.call(v) }
  new_hash
end

double = Proc.new { |n| n * 2 }
p hash_mapped({'a'=>4, 'x'=>7, 'c'=>-3}, double) { |k| k.upcase + '!!' }
# {"A!!"=>8, "X!!"=>14, "C!!"=>-6}

first = Proc.new { |a| a[0] }
p hash_mapped({-5=>['q', 'r', 's'], 6=>['w', 'x']}, first) { |n| n * n }
# {25=>"q", 36=>"w"}

def counted_characters(str)
  hash = Hash.new { |h, k| h[k] = 0 }
  str.each_char { |c| hash[c] += 1 }
  hash.select { |k, v| v > 2 }.keys
end

p counted_characters("that's alright folks") # ["t"]
p counted_characters("mississippi") # ["i", "s"]
p counted_characters("hot potato soup please") # ["o", "t", " ", "p"]
p counted_characters("runtime") # []

def triplet_true(str)
  hash = Hash.new { |h, k| h[k] = 0 }
  str.each_char { |c| hash[c] += 1 }
  hash.any? { |k, v| v > 2 }
end

p triplet_true('caaabb')        # true
p triplet_true('terrrrrible')   # true
p triplet_true('runninggg')     # true
p triplet_true('bootcamp')      # false
p triplet_true('e')             # false

def energetic_encoding(str, hash)
  str.split(' ').map do |word|
    new_str = ''
    word.each_char { |c| new_str << (hash.key?(c) ? hash[c] : '?' )}
    new_str
  end .join(' ')
end

p energetic_encoding('sent sea',
    'e'=>'i', 's'=>'z', 'n'=>'m', 't'=>'p', 'a'=>'u'
) # 'zimp ziu'

p energetic_encoding('cat',
    'a'=>'o', 'c'=>'k'
) # 'ko?'

p energetic_encoding('hello world',
    'o'=>'i', 'l'=>'r', 'e'=>'a'
) # '?arri ?i?r?'

p energetic_encoding('bike', {}) # '????'

def uncompress(str)
  uncompressed = ''
  (0...str.length).step(2) { |i| uncompressed << (str[i] * str[i + 1].to_i) }
  uncompressed
end

puts uncompress('a2b4c1') # 'aabbbbc'
puts uncompress('b1o2t1') # 'boot'
puts uncompress('x3y1x2z4') # 'xxxyxxzzzz'

def conjunct_select(arr, *prcs)
  arr.select { |el| prcs.all? { |prc| prc.call(el) }}
end

is_positive = Proc.new { |n| n > 0 }
is_odd = Proc.new { |n| n.odd? }
less_than_ten = Proc.new { |n| n < 10 }

p conjunct_select([4, 8, -2, 11, 7, -3, 13], is_positive) # [4, 8, 11, 7, 13]
p conjunct_select([4, 8, -2, 11, 7, -3, 13], is_positive, is_odd) # [11, 7, 13]
p conjunct_select([4, 8, -2, 11, 7, -3, 13], is_positive, is_odd, less_than_ten) # [7]

def convert_pig_latin(str)
  vowels = 'aeiouAEIOU'
  str.split(' ').map do |word|
    converted = nil
    if word.length < 3
      converted = word
    elsif vowels.include? word[0]
      converted = word + 'yay'
    else
      i = word.index(/[aeiouAEIOU]/)
      converted = (i.nil? ? word + 'ay' : word[i..-1] + word[0...i] + 'ay')
    end
    word == word.capitalize ? converted.capitalize : converted
  end .join(' ')
end

p convert_pig_latin('We like to eat bananas') # "We ikelay to eatyay ananasbay"
p convert_pig_latin('I cannot find the trash') # "I annotcay indfay ethay ashtray"
p convert_pig_latin('What an interesting problem') # "Atwhay an interestingyay oblempray"
p convert_pig_latin('Her family flew to France') # "Erhay amilyfay ewflay to Ancefray"
p convert_pig_latin('Our family flew to France') # "Ouryay amilyfay ewflay to Ancefray"

def reverberate(str)
  vowels = 'aeiouAEIOU'
  str.split(' ').map do |word|
    converted = nil
    if word.length < 3
      converted = word
    elsif vowels.include? word[-1]
      converted = word * 2
    else
      i = nil
      word.each_char.with_index { |c, idx| i = idx if vowels.include?(c) }
      converted = (i.nil? ? word : word + word[i..-1])
    end
    word == word.capitalize ? converted.capitalize : converted
  end .join(' ')
end

p reverberate('We like to go running fast') # "We likelike to go runninging fastast"
p reverberate('He cannot find the trash') # "He cannotot findind thethe trashash"
p reverberate('Pasta is my favorite dish') # "Pastapasta is my favoritefavorite dishish"
p reverberate('Her family flew to France') # "Herer familyily flewew to Francefrance"

def disjunct_select(arr, *prcs)
  arr.select { |el| prcs.any? { |prc| prc.call(el) }}
end

longer_four = Proc.new { |s| s.length > 4 }
contains_o = Proc.new { |s| s.include?('o') }
starts_a = Proc.new { |s| s[0] == 'a' }

p disjunct_select(['ace', 'dog', 'apple', 'teeming', 'boot', 'zip'],
    longer_four,
) # ["apple", "teeming"]

p disjunct_select(['ace', 'dog', 'apple', 'teeming', 'boot', 'zip'],
    longer_four,
    contains_o
) # ["dog", "apple", "teeming", "boot"]

p disjunct_select(['ace', 'dog', 'apple', 'teeming', 'boot', 'zip'],
    longer_four,
    contains_o,
    starts_a
) # ["ace", "dog", "apple", "teeming", "boot"]

def last_vowel_idx(word, vowels)
  idx = nil
  word.each_char.with_index { |c, i| idx = i if vowels.include?(c) }
  idx
end

def alternating_vowel(str)
  vowels = 'aeiou'
  str.split(' ').map.with_index do |word, i|
    idx = (i.even? ? word.index(/[aeiou]/) : last_vowel_idx(word, vowels))
    word[idx] = '' unless idx.nil?
    word
  end .join(' ')
end

p alternating_vowel('panthers are great animals') # "pnthers ar grat animls"
p alternating_vowel('running panthers are epic') # "rnning panthrs re epc"
p alternating_vowel('code properly please') # "cde proprly plase"
p alternating_vowel('my forecast predicts rain today') # "my forecst prdicts ran tday"

def silly_talk(str)
  vowels = 'aeiouAEIOU'
  str.split(' ').map do |word|
    converted = nil
    if vowels.include? word[-1]
      converted = word + word[-1]
    else
      converted = ''
      word.each_char do |c|
        converted << c
        converted << 'b' + c if vowels.include?(c)
      end
    end
    word == word.capitalize ? converted.capitalize : converted
  end .join(' ')
end

p silly_talk('Kids like cats and dogs') # "Kibids likee cabats aband dobogs"
p silly_talk('Stop that scooter') # "Stobop thabat scobooboteber"
p silly_talk('They can code') # "Thebey caban codee"
p silly_talk('He flew to Italy') # "Hee flebew too Ibitabaly"

def compress(str)
  compressed = ''
  count = 1
  str.each_char.with_index do |c, i|
    if c != str[i + 1]
      compressed << c
      compressed << count.to_s unless count == 1
      count = 1
    else
      count += 1
    end
  end
  compressed
end

p compress('aabbbbc')   # "a2b4c"
p compress('boot')      # "bo2t"
p compress('xxxyxxzzzz')# "x3yx2z4"