require_relative 'piece'
require_relative 'slideable'

class Rook < Piece
  include Slideable

  def initialize
    super
  end

  def move_dirs
    Piece::DIRS
  end

  def to_s
    (color == :white) ? "\u2656" : "\u265C"
  end
end
