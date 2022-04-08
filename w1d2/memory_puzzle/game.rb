require_relative 'board.rb'
require_relative 'human_player.rb'
require_relative 'ai_player.rb'

class Game
  def initialize(player)
    @board = Board.new
    @player = player
    @prev_guess = nil
  end

  def run
    play_round until over?
    puts 'You win!'
  end

  def play_round
    @board.render
    make_guess
    @board.render
  end

  def make_guess
    guess = player_input
    card = @board[guess]
    @player.give_ai_info(card.reveal, guess)
    @board.render

    if @prev_guess
      cards_not_equal(card) if card != @prev_guess
      @prev_guess = nil
    else
      @prev_guess = card
    end
  end

  def cards_not_equal(card)
    sleep(2)
    card.hide
    @prev_guess.hide
  end

  def over?
    @board.won?
  end

  def player_input
    input = false
    until input
      input = @player.get_input
      input = false unless valid_input?(input)
    end
    input
  end

  def valid_input?(input)
    input.length == 2 && @board.between_bounds?(input) &&
      !@board[input].revealed?
  end
end

h = HumanPlayer.new(4)
a = AiPlayer.new(4)

g = Game.new(a)
g.run
