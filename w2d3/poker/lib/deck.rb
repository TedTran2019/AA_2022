require_relative 'card'

# Make sure your terminal has UTF-8 encoding
# Suggest: Terminal font size of 64, white background, black text
class Deck
  UNICODE = ((1..9).to_a + ('A'..'D').to_a).freeze
  SUITES = %i[spade heart diamond club].freeze

  attr_reader :deck

  def self.create_deck
    deck = []
    4.times do |y|
      13.times do |x|
        value = (x.zero? ? 14 : x + 1)
        unicode = ["1F0#{UNICODE[y + 9]}#{UNICODE[x]}".hex].pack('U')
        deck << Card.new(value, SUITES[y], unicode)
      end
    end
    deck
  end

  def initialize
    @deck = Deck.create_deck.shuffle!
  end

  def deal(card_amount)
    cards = []
    card_amount.times { cards << @deck.pop }
    cards
  end

  def [](idx)
    @deck[idx]
  end
end
