class Board
  def initialize(n)
    @grid = Array.new(n) { Array.new(n, '_')}
    @size = n
  end

  def valid?(pos)
    pos[0].between?(0, @size - 1) && pos[1].between?(0, @size - 1)
  end

  def empty?(pos)
    @grid[pos[0]][pos[1]] == '_'
  end

  def place_mark(pos, mark)
    raise 'Invalid placement!' unless (valid?(pos) && empty?(pos))
    @grid[pos[0]][pos[1]] = mark
  end

  def print_board
    @grid.each do |row|
      row.each { |el| print "#{el} " }
      print "\n"
    end
  end

  def win_row?(mark)
    @grid.any? { |row| row.all? { |el| el == mark }}
  end

  def win_col?(mark)
    @grid.transpose.any? { |col| col.all? { |el| el == mark }}
  end

  def win_diagonal?(mark)
    return true if (0...@size).all? { |i| @grid[i][i] == mark }
    diag = []
    @grid.length.times { |i| diag << [i, @size - 1 - i] }
    diag.all? { |pos| @grid[pos[0]][pos[1]] == mark }
  end

  def win?(mark)
    win_row?(mark) || win_col?(mark) || win_diagonal?(mark)
  end

  def empty_positions?
    @grid.any? { |row| row.any? { |el| el == '_'}}
  end
end
