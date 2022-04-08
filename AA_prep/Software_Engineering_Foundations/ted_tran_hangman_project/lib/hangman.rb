class Hangman
  DICTIONARY = ["cat", "dog", "bootcamp", "pizza"]

  attr_reader :guess_word, :attempted_chars, :remaining_incorrect_guesses

  def self.random_word
    DICTIONARY.sample
  end

  def initialize
    @secret_word = Hangman.random_word
    @guess_word = Array.new(@secret_word.length, '_')
    @attempted_chars = []
    @remaining_incorrect_guesses = 5
  end

  def already_attempted?(chr)
    attempted_chars.include?(chr)
  end

  def get_matching_indices(chr)
    indices = []
    @secret_word.each_char.with_index { |c, i| indices << i if c == chr }
    indices
  end

  def fill_indices(chr, indices)
    indices.each { |i| guess_word[i] = chr }
  end

  def try_guess(chr)
    if already_attempted?(chr)
      print 'that has already been attempted'
      false
    else
      attempted_chars << chr
      indices = get_matching_indices(chr)
      indices.empty? ? @remaining_incorrect_guesses -= 1 : fill_indices(chr, indices)
      true
    end
  end
  
  def ask_user_for_guess
    print 'Enter a char:'
    input = gets.chomp
    try_guess(input)
  end

  def win?
    if guess_word.join('') == @secret_word 
      print 'WIN'
      true
    else
      false
    end
  end
  
  def lose?
    if remaining_incorrect_guesses.zero?
      print 'LOSE'
      true
    else
      false
    end
  end

  def game_over?
    if win? || lose? 
      print @secret_word
      true
    else
      false
    end
  end
end
