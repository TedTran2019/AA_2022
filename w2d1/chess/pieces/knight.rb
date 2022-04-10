require_relative 'piece'
require_relative '../modules/stepable'

class Knight < Piece
  KNIGHT_DIRS = [[2, 1], [2, -1], [-2, -1], [-2, 1],
                [1, 2], [-1, 2], [1, -2], [-1, -2]].freeze
  include Stepable

  def initialize(pos, color, board)
    super
  end

  def move_dirs
    Knight::KNIGHT_DIRS
  end

  def to_s
    (color == :white) ? "\u2658" : "\u265E"
  end
end