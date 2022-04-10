require_relative 'piece'
require_relative 'stepable'

class King < Piece
  include Stepable

  def initialize
    super
  end

  def to_s
    (color == :white) ? "\u2654" : "\u265A"
  end
end