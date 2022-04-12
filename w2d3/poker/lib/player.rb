require_relative 'hand'
class Player
  attr_reader :hand, :name
  attr_accessor :pot

  def initialize(name)
    @name = name
    @hand = Hand.new
    @pot = 10
    @folded = false
  end

  def raise
    @pot -= 1
    1
  end

  def show_hand
    print "#{@name}'s hand: "
    @hand.cards.each { |card| print "#{card} "}
    print "\n"
  end

  def cards_in_hand
    @hand.cards.length
  end

  def fold
    @folded = true
  end

  def unfold
    @folded = false
  end

  def folded?
    @folded
  end

  def take_cards(cards)
    @hand.take_cards(cards)
  end

  def discard_cards(discard)
    @hand.discard_cards(discard)
  end

  def get_action_input
    input = nil
    action_prompt
    until input && valid_action_input?(input)
      input = gets.chomp
    end
    input
  end

  def get_discard_input
    input = nil
    discard_prompt
    until input && valid_discard_input?(input)
      input = gets.chomp.split(' ').map(&:to_i)
    end
    input
  end

  def valid_action_input?(input)
    return false unless %w[f b r].include?(input)

    if input == 'r' && @pot < 1
      puts "You don't have enough money, looks like you can only fold!"
      false
    else
      true
    end
  end

  def valid_discard_input?(input)
    input.length < 4 &&
      input.all? { |n| n.between?(0, 4) } &&
      input.uniq == input
  end

  def action_prompt
    puts 'Do you wish to: fold[f], see current bet[b], or raise[r] by 1?'
  end

  def discard_prompt
    puts 'Discard 0-3 cards. Enter by index separated by spaces'
  end
end