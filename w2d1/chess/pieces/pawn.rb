require_relative 'piece'

class Pawn < Piece
  include Stepable

  def initialize
    super
  end

  def to_s
    (color == :white) ? "\u2659" : "\u265F"
  end
end