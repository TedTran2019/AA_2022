# frozen_string_literal: true

# Write a method, compress_str(str), that accepts a string as an arg.
# The method should return a new str where streaks of consecutive characters are compressed.
# For example "aaabbc" is compressed to "3a2bc".

def compress_str(str)
  comp_str = ''
  i = 0
  repeat = 1
  while i < str.length

    if str[i] == str[i + 1]
      repeat += 1
    else
      comp_str << repeat.to_s unless repeat == 1
      comp_str << str[i]
      repeat = 1
    end

    i += 1
  end
  comp_str
end

p compress_str('aaabbc')        # => "3a2bc"
p compress_str('xxyyyyzz')      # => "2x4y2z"
p compress_str('qqqqq')         # => "5q"
p compress_str('mississippi')   # => "mi2si2si2pi"
