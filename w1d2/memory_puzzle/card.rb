class Card
  attr_reader :face

  def initialize(val)
    @val = val
    @face = false
  end

  def val
    @val if @face
  end

  def hide
    @face = false
  end

  def reveal
    @face = true
    @val
  end

  def to_s
    @face ? @val : '_'
  end

  def revealed?
    @face
  end

  def ==(other_card)
    return false unless @face && other_card.face

    val == other_card.val
  end
end