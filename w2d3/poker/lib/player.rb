class Player
  def initialize(name)
    @hand = Hand.new
    @pot = 1000
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

  def take_cards
  end

  def discard_cards
  end

  def get_input
  end
end