require 'colorize'

class Card
  FACE = (('2'..'10').to_a + %w[J Q K A]).freeze
  SUITE = {
    spade: "\u2660",
    club: "\u2663",
    diamond: "\u2666".colorize(:red),
    heart: "\u2665".colorize(:red)
  }.freeze

  attr_reader :value, :suite, :unicode

  def initialize(value, suite, unicode = nil)
    @value = value
    @suite = suite
    @unicode = unicode
  end

  def to_s
    @unicode.nil? ? face : @unicode
  end

  def face
    Card::FACE[value - 2] + Card::SUITE[suite]
  end
end
