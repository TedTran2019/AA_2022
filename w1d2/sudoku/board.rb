require_relative 'tile'

class Board
  def self.from_file(file)
    grid = []
    File.foreach(file) do |line|
      grid << line.chomp.split('').map { |n| Tile.new(n, n != '0') }
    end
    grid
  end

  def initialize(grid)
    @grid = grid
    @size = 9
  end

  def [](pos)
    y, x = pos
    @grid[y][x]
  end

  def []=(pos, val)
    y, x = pos
    @grid[y][x].value = val
  end

  def solved?
    rows_solved?(@grid) && rows_solved?(@grid.transpose) && blocks_solved?
  end

  def render
    system('clear')
    @grid.each_with_index do |row, y|
      puts '  0 1 2 3 4 5 6 7 8'.colorize(:blue) if y.zero?
      row.each_with_index do |n, x|
        print "#{y} ".colorize(:blue) if x.zero?
        print n
      end
      print "\n"
    end
  end

  # Transpose grid and add to here to check if cols_solved?
  # Quick one liner to ensure no zeroes in solved
  def rows_solved?(grid)
    grid.all? do |row|
      dict = Hash.new { |h, k| h[k] = 0 }
      row.each do |tile| 
        return false if tile.value == '0'

        dict[tile.value] += 1
      end
      dict.all? { |_, v| v == 1 }
    end
  end

  def blocks_solved?
    (0...3).all? { |n| block_solved?(n * 3) }
  end

  def block_solved?(n)
    dict = Hash.new { |h, k| h[k] = 0 }
    (n...(n + 3)).each do |y|
      (n...(n + 3)).each do |x|
        dict[self[[y, x]].value] += 1
      end
    end
    dict.all? { |_, v| v == 1 }
  end
end