require_relative 'board'

class HumanPlayer
  attr_reader :color
  
  def initialize(color, board)
    @color = color
    @board = board
  end

  def make_move
    input = nil
    until input
      @board.display.render
      input = @board.display.cursor.get_input
    end
    input
  end
end