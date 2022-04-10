require_relative 'piece'
require_relative '../modules/stepable'

class King < Piece
  include Stepable

  def initialize(pos, color, board)
    super
  end

  def move_dirs
    Piece::DIAG_DIRS + Piece::DIRS
  end

  def to_s
    (color == :white) ? "\u2654" : "\u265A"
  end
end