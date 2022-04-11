class Player
  def initialize(name)
    @hand = Hand.new
    @pot = 10
    @folded = false
  end

  def fold
    @folded = false
  end

  def unfold
    @folded = true
  end

  def folded?
    @folded
  end

  def take_cards(cards)
    @hand.cards.concat(cards)
    @hand.sort_all
  end

  def discard_cards
  end

  def get_action_input
  end

  def get_discard_input
  end

  def action_prompt
    puts 'Do you wish to: fold[f], see current bet[b], or raise[r] by 1?'
  end

  def discard_prompt
    puts 'Discard 0-3 cards. Enter by index separated by spaces'
  end
end