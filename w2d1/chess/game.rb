require_relative 'board'
require_relative 'human_player'
class Game
  def initialize
    @board = Board.new
    @p1 = HumanPlayer.new(:white, @board)
    @p2 = HumanPlayer.new(:black, @board)
    @current_player = @p1
  end

  def play_round
    start_pos = @current_player.make_move
    end_pos = @current_player.make_move
    @board.move_piece(@current_player.color, start_pos, end_pos)
    toggle_player
  rescue StandardError => e
    puts e.message
    retry
  end

  def toggle_player
    @current_player = (@current_player == @p1 ? @p2 : @p1)
  end

  def play
    @board.display.render
    play_round until game_over?
    @board.display.render
  end

  def game_over?
    @board.checkmate?(:white) || @board.checkmate?(:black) || 
    @board.no_moves?(@current_player.color)
  end
end

if __FILE__ == $PROGRAM_NAME
  chess = Game.new
  chess.play
end