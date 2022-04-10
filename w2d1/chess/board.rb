require_relative 'pieces/pieces'
require_relative 'display/display'
class Board
  attr_reader :grid

  def initialize
    @grid = Array.new(8) { Array.new(8, nil) }
    populate_grid
    @display = Display.new(self)
  end

  # Once players are factored in, valid_move only takes if str_pos is same color
  # Also factor in check into available moves later on
  def move_piece(start_pos, end_pos)
    return false unless valid_move?(start_pos, end_pos)
    piece = self[start_pos]
    piece.pos = end_pos
    self[end_pos] = piece
    self[start_pos] = NullPiece.instance
  end
    
  def valid_move?(start_pos, end_pos)
    return false unless self[start_pos].space_taken?

    self[start_pos].moves.include?(end_pos)
  end

  def space_taken?(pos)
    k.class != NullPiece
  end

  def space_open?(pos)
    k.class == NullPiece
  end

  def out_of_bounds?(y, x)
    y.negative? || x.negative? || y > 7 || x > 7
  end

  def []=(pos, val)
    y, x = pos
    @grid[y][x] = val
  end

  def [](pos)
    y, x = pos
    @grid[y][x]
  end

  def populate_grid
    fill_major(:white, 7)
    fill_major(:black, 0)
    fill_minor(:white, 6)
    fill_minor(:black, 1)
    fill_empty
  end

  def fill_major(color, row)
    @grid[row].each_with_index do |_, col|
      pos = [row, col]
      case col
      when 0, 7
        self[pos] = Rook.new(pos, color, self)
      when 1, 6
        self[pos] = Knight.new(pos, color, self)
      when 2, 5
        self[pos] = Bishop.new(pos, color, self)
      when 3
        self[pos] = King.new(pos, color, self)
      when 4
        self[pos] = Queen.new(pos, color, self)
      end
    end
  end

  def fill_minor(color, row)
    @grid[row].each_with_index do |_, col|
      pos = [row, col]
     self[pos] = Pawn.new(pos, color, self) 
    end
  end

  def fill_empty
    (2...6).each do |y|
      (0...8).each do |x|
        @grid[y][x] = NullPiece.instance
      end
    end
  end
end

b = Board.new
b.display.test