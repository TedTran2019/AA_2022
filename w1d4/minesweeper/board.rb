require_relative 'tile'

# 0 surrounding bombs == blank tile
# otherwise number indicating number of bombs
# if there's a bomb inside of tile, leave hidden until revealed
# Stop revealing outwards when you reach a tile with bombs surrounding it
class Board
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
    grid
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
    @grid.all? { |row| row.all?(&:revealed?) }
  end
end