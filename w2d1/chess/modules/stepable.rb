module Stepable
  def moves
    possible_moves = []
    y, x = pos
    move_dirs.each do |d_pos|
      dy, dx = d_pos
      new_pos = [y + dy, x + dx]
      possible_moves << new_pos unless invalid_spot?(new_pos)
    end
    possible_moves
  end
end
