require_relative 'piece'
require_relative 'slideable'

class Queen < Piece
  include Slideable

  def initialize
    super
  end

  def move_dirs
    Piece::DIRS + Piece::DIAG_DIRS
  end

  def to_s
    (color == :white) ? "\u2655" : "\u265B"
  end
end