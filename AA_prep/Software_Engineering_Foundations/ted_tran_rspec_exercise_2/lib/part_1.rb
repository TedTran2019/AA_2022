def partition(arr, nbr)
  separated = Array.new(2) { [] }
  arr.each { |num| num >= nbr ? separated[1] << num : separated[0] << num }
  separated
end

def merge(hash1, hash2)
  new_hash = Hash.new
  hash1.each { |k, v| new_hash[k] = v }
  hash2.each { |k, v| new_hash[k] = v }
  new_hash
end

def censor_word(word)
  vowels = 'aeiouAEIOU'
  censored = ''
  word.each_char do |char|
    if vowels.include? char
      censored += '*'
    else
      censored += char
    end
  end
  censored
end

# This is probably a good problem to use Regex on instead of include?
def censor(sent, curses)
  curses.map! { |word| word.downcase }
  sent.split(' ').map { |word| (curses.include? word.downcase) ? censor_word(word) : word }
  .join(' ')
end

def power_of_two?(nbr)
  return true if nbr == 1
  return false if nbr < 1
  power_of_two?(nbr / 2.0)
end