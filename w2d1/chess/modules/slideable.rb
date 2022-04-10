# Go thru list of possible steps
# For every step, continue on the dy/dx to y/x until out of bounds OR not nil
# Add all moves along the way to possible_moves arr
module Slideable
  def moves
    possible_moves = []
    move_dirs.each do |d_pos|
      y, x = pos
      dy, dx = d_pos
      y += dy
      x += dx
      until invalid_spot?([y, x])
        possible_moves << [y, x]
        break if @board.space_taken? ([y, x])
        y += dy
        x += dx
      end
    end
    possible_moves
  end
end