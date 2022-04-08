class Board

  attr_reader :size

  def self.print_grid(grid)
    grid.each do |row|
      row.each_with_index { |el, i| print i == (row.length - 1) ? el : "#{el} " }
      print "\n"
    end
  end

  def initialize(nbr)
    @grid = Array.new(nbr) { Array.new(nbr, :N) }
    @size = nbr * nbr
  end

  def [](pos)
    @grid[pos[0]][pos[1]]
  end
  
  def []=(pos, val)
    @grid[pos[0]][pos[1]] = val
  end

  def num_ships
    @grid.sum { |row| row.sum { |el| el == :S ? 1 : 0 }}
  end

  def attack(pos)
    if self[pos] == :S
      self[pos] = :H
      puts 'you sunk my battleship!'
      true
    else
      self[pos] = :X
      false
    end
  end

  def place_random_ships
    n = @grid.length
    s_elements = 0
    until s_elements >= size / 4
      pos = [rand(0...n), rand(0...n)]
      (self[pos] = :S) && s_elements += 1 unless self[pos] == :S
    end
  end

  def hidden_ships_grid
    @grid.map { |row| row.map { |el| el == :S ? :N : el }}
  end

  def cheat
    Board.print_grid(@grid)
  end

  def print
    Board.print_grid(hidden_ships_grid)
  end
end
