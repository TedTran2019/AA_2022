require_relative 'piece'
require 'singleton'
class NullPiece < Piece
  include Singleton

  def initialize
    @color = nil
  end

  def to_s
    "\u25A1"
  end
end