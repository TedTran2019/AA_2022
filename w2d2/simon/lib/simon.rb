class Simon
  COLORS = %w(red blue green yellow)

  attr_accessor :sequence_length, :game_over, :seq

  def initialize
    @sequence_length = 1
    @game_over = false
    @seq = []
  end

  def play
    take_turn until @game_over
    game_over_message
    reset_game
  end

  def take_turn
    show_sequence
    require_sequence
    unless @game_over
      round_success_message
      @sequence_length += 1
    end
  end

  def show_sequence
    add_random_color
    print "#{@seq}\n"
    sleep(3)
    system('clear')
  end

  def require_sequence
    @seq.each do |color|
      input = gets.chomp
      if input != color
        @game_over = true
        return false
      end
    end
    true
  end

  def add_random_color
    @seq << Simon::COLORS.sample
  end

  def round_success_message
    puts "You've made it through this round!"
  end

  def game_over_message
    puts "You've lost!"
  end

  def reset_game
    @sequence_length = 1
    @game_over = false
    @seq = []
  end
end