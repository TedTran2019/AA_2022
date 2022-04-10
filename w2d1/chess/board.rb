require_relative 'pieces/pieces'

class Board

  def self.create_chess_board
    pieces_row_idx = [0, 1, 6, 7]
    grid = Array.new(8) { Array.new(8, nil) }
    pieces_row_idx.each_with_index do |y|
      8.times { |x| grid[y][x] = Piece.new([y, x])}
    end
    grid
  end

  def initialize
    @grid = Array.new(8) { Array.new(8, nil) }
    populate_grid
  end

  def move_piece(start_pos, end_pos)
    valid_move?(start_pos, end_pos)
    piece = self[start_pos]
    piece.pos = end_pos
    self[end_pos] = piece
    self[start_pos] = nil
  end

  # Handle possible moves later or NullPiece inclusion
  def valid_move?(start_pos, end_pos)
    raise 'Invalid Move' if self[start_pos].nil? || !self[end_pos].nil?
  end

  # Make a space taken by same color after to deal w/ Stepable/Slideable logic
  def space_taken?(pos)
    !self[pos].nil?
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

  def render

  end

  def populate_grid
    fill_empty
  end

  def fill_black_major

  end

  def fill_empty
    (2...6).each do |y|
      (0...8).each do |x|
        @grid[y][x] = NullPiece.instance
      end
    end
  end
end
