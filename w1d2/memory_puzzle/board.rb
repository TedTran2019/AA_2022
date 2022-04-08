require_relative 'card.rb'

class Board
  CARDS = ('0'..'9').to_a + ('a'..'z').to_a + ('A'..'Z').to_a

  def initialize
    @pairs = 8
    @size = Math.sqrt(@pairs * 2)
    @grid = []
    populate_grid
  end

  def populate_grid
    cards = (CARDS[0...@pairs] * 2).shuffle
    (0...@size).each do |y|
      sub_arr = []
      (0...@size).each do |x|
        sub_arr << Card.new(cards.pop)
      end
      @grid << sub_arr
    end
  end
  
  def render
    system("clear")
    top = (0...@size).to_a.map { |n| "#{n} "}.join
    @grid.each_with_index do |row, y|
      puts "  #{top}" if y.zero?
      row.each_with_index do |card, x|
        print "#{y} " if x.zero?
        print "#{card} "
      end
      print "\n"
    end
  end

  def won?
    @grid.all? { |row| row.all? { |card| card.face }}
  end

  def [](pos)
    y, x = pos
    @grid[y][x]
  end

  def reveal(guessed_pos)
    self[guessed_pos].reveal
  end

  def between_bounds?(pos)
    y, x = pos
    y.between?(0, @size - 1) && x.between?(0, @size - 1)
  end
end