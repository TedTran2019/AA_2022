require_relative 'tile'

# if there's a bomb inside of tile, leave hidden until revealed
# Stop revealing outwards when you reach a tile with bombs surrounding it
class Board

  ALL_DIRS = [[0, 1], [0, -1], [1, 0], [-1, 0],
            [1, -1], [1, 1], [-1, -1], [-1, 1]].freeze

  def self.create_board(size)
    self.new(size)
  end

  def initialize(size)
    @size = size
    @nbr_bombs = (size**2) / 8
    @grid = create_grid
  end

  def create_grid
    bomb_arr = create_bombs
    grid = Array.new(@size) { Array.new(@size) }
    grid.each do |row|
      row.each_with_index do |_el, x|
        row[x] = Tile.new(bomb_arr.pop)
      end
    end
    set_neighbor_bomb_count(grid)
    grid
  end

  def set_neighbor_bomb_count(grid)
    grid.each_with_index do |row, y|
      row.each_with_index do |tile, x|
        next if tile.bomb?

        tile.neighbor_bomb_count = neighbor_bombs(grid, y, x)
      end
    end
  end

  def neighbor_bombs(grid, y, x)
    bombs = 0
    ALL_DIRS.each do |pos|
      dy, dx = pos
      dy += y
      dx += x
      next unless between_bounds?(dy, dx)

      bombs += 1 if grid[dy][dx].bomb?
    end
    bombs
  end

  def create_bombs
    bomb_arr = Array.new(@nbr_bombs, true)
    non_bombs = Array.new((@size**2) - @nbr_bombs, false)
    (bomb_arr + non_bombs).shuffle
  end

  def render
    puts "  #{(0...@size).to_a.join(' ')}"
    @grid.each_with_index do |row, y|
      row.each_with_index do |el, x|
        print "#{y} " if x == 0
        print "#{el} "
      end
      print "\n"
    end
  end

  def [](pos)
    y, x = pos
    @grid[y][x] 
  end

  def between_bounds?(y, x)
    y > -1 && y < @size &&
      x > -1 && x < @size
  end

  def lost?
    @grid.any? { |row| row.any?(&:bomb_revealed?) }
  end

  def won?
    @grid.all? { |row| row.all? { |el| el.revealed? || el.bomb? }}
  end
end