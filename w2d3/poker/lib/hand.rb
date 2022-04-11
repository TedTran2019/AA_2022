class Hand
  include Comparable

  RANK = %i[high_card pair two_pair three_kind 
    straight flush full_house four_kind straight_flush].freeze

  attr_reader :cards, :count

  def initialize
    @cards = []
    @count = nil
  end

  def sort_all
    @cards.sort { |a, b| b.value <=> a.value }
    sorted_count
  end

  def value
    Hand::RANK.each_with_index {|rank, i| return i if method(rank).call }
  end

  def <=>(other_hand)
    if self.value > other_hand.value
      1
    elsif self.value == other_hand.value
      tiebreaker(other_hand)
    else
      -1
    end
  end

  def tiebreaker(other_hand)
    @count.each_with_index do |kv, i|
      if kv[0] > other_hand.count[i][0]
        1
      elsif kv[0] < other_hand.count[i][0]
        -1
      end
    end
    0
  end

  def straight_flush
    4.times do |i|
      return false unless cards[i].value == (cards[i + 1].value - 1) &&
                          cards[i].suite == cards[i + 1].suite
    end
    true
  end

  def four_kind
    @count.any? { |kv| kv[1] == 4 }
  end

  def full_house
    @count.length == 2 && @count[0][1] == 3
  end

  def flush
    4.times { |i| return false unless cards[i].suite == cards[i + 1].suite }
    true
  end

  def straight
    4.times { |i| return false unless cards[i].value == cards[i + 1].value - 1 }
    true
  end

  def three_kind
    @count.any? { |kv| kv[1] == 3 }
  end

  def two_pair
    @count.length == 3
  end

  def pair
    @count.length == 4
  end

  def high_card
    true
  end

  def sorted_count
    count = Hash.new { |h, k| h[k] = 0 }
    @cards.each { |card| count[card.value] += 1 }
    count_arr = count.to_a
    count_arr.sort! do |a, b|
      if a[1] == b[1]
        b[0] <=> a[0]
      else
        b[1] <=> a[1]
      end
    end
    @count = count_arr
  end
end
