class Piece

  DIAG_DIRS = [[1, 1], [1, -1], [-1, 1], [-1, -1]].freeze
  DIRS = [[1, 0], [-1, 0], [0, -1], [0, 1]].freeze

  attr_accessor :pos, :board
  attr_reader :color

  def initialize(pos, color, board)
    @pos = pos
    @color = color
    @board = board
  end

  def invalid_spot?(pos)
    @board.out_of_bounds?(*pos) || ally_piece?(pos)
  end

  def valid_moves
    moves.reject { |move| move_into_check?(move) }
  end

  def move_into_check?(end_pos)
    clone = @board.dup
    clone.move_piece!(pos, end_pos)
    clone.in_check?(color)
  end

  def ally_piece?(pos)
    @board[pos].color == color
  end

  def enemy_piece?(pos)
    return false if @board.space_open?

    !ally_piece?(pos)
  end
end
