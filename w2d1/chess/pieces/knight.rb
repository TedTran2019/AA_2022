require_relative 'piece'
require_relative 'stepable'

class Knight < Piece
  KNIGHT_DIRS = [[2, 1], [2, -1], [-2, -1], [-2, 1],
                [1, 2], [-1, 2], [1, -2], [-1, -2]].freeze
  include Stepable

  def initialize
    super
  end

  def to_s
    (color == :white) ? "\u2658" : "\u265E"
  end
end