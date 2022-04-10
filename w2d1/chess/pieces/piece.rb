class Piece

  DIAG_DIRS = [[1, 1], [1, -1], [-1, 1], [-1, -1]].freeze
  DIRS = [[1, 0], [-1, 0], [0, -1], [0, 1]].freeze

  attr_accessor :pos

  def initialize(pos, color, board)
    @pos = pos
    @color = color
    @board = board
  end

  def invalid_spot?(pos)
    @board.space_taken(pos) || @board.out_of_bounds?(*pos)
  end
end