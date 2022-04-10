require_relative 'piece'
require_relative 'slideable'

class Bishop < Piece
  include Slideable

  def initialize
    super
  end

  def move_dirs
    Piece::DIAG_DIRS
  end

  def to_s
    (color == :white) ? "\u2657" : "\u265D"
  end
end