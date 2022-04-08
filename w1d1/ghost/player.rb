class Player
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def guess
    puts 'Enter your guess! Put in a letter!'
    input = gets.chomp.downcase
    unless input.length == 1 && input.match?(/[a-z]/)
      alert_invalid_guess
      return false
    end
    input
  end
  
  private

  def alert_invalid_guess
    puts 'Invalid guess! It has to be a single letter from a-z'
  end
end