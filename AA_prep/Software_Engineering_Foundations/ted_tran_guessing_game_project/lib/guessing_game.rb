class GuessingGame
  attr_reader :num_attempts

  def initialize(min, max)
    @secret_num = rand(min..max)
    @num_attempts = 0
    @game_over = false
  end

  def game_over?
    @game_over
  end

  def check_num(nbr)
    if nbr == @secret_num
      @game_over = true
      puts 'you win'
    elsif nbr > @secret_num
      puts 'too big'
    else
      puts 'too small'
    end
    @num_attempts += 1
  end
  
  def ask_user
    print 'enter a number'
    input = gets.chomp.to_i
    check_num(input)
  end
end
