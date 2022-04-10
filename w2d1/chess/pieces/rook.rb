require_relative 'piece'
require_relative '../modules/slideable'

class Rook < Piece
  include Slideable

  def initialize(pos, color, board)
    super
  end

  def move_dirs
    Piece::DIRS
  end

  def to_s
    (color == :white) ? "\u2656" : "\u265C"
  end
end
