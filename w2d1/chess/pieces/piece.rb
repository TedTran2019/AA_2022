class Piece

  DIAG_DIRS = [[1, 1], [1, -1], [-1, 1], [-1, -1]].freeze
  DIRS = [[1, 0], [-1, 0], [0, -1], [0, 1]].freeze

  attr_accessor :pos
  attr_reader :color

  def initialize(pos, color, board)
    @pos = pos
    @color = color
    @board = board
  end

  def invalid_spot?(pos)
    @board.out_of_bounds?(*pos) || ally_piece?(pos)
  end

  def ally_piece?(pos)
    @board[pos].color == color
  end

  def enemy_piece?(pos)
    return false if @board.space_open?

    !ally_piece?(pos)
  end
end