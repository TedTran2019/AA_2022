require_relative 'piece'
require_relative '../modules/slideable'

class Queen < Piece
  include Slideable

  def initialize(pos, color, board)
    super
  end

  require 'byebug'
  def move_dirs
    # debugger
    Piece::DIRS + Piece::DIAG_DIRS
  end

  def to_s
    (color == :white) ? "\u2655" : "\u265B"
  end
end