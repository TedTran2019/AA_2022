require_relative 'piece'

class Pawn < Piece
  def initialize(pos, color, board)
    super
  end

  def moves
    forward_steps
  end

  def to_s
    (color == :white) ? "\u2659" : "\u265F"
  end

  def at_start_row?(row)
    if color == :black && row == 1 
      true
    elsif color == :white && row == 6
      true
    else
      false
    end
  end

  def forward_dir
    color == :black ? 1 : -1
  end

  def forward_steps
    movement = (at_start_row? ? 2 : 1 ) * forward_dir
    possible_moves = []
    y, x = pos
    movement.times do 
      y += forward_dir
      possible_moves << [y, x] unless @board.out_of_bounds?(y, x) || space_taken?([y, x])
    end
    possible_moves.concat(side_attacks)
  end

  def side_attacks
    possible_moves = []
    y, x = pos
    s1 = [forward_dir, 1]
    s2 = [forward_dir, -1]
    possible_moves << [y + s1[0], x + s1[1]] if enemy_piece?([y + s1[0], x + s1[1]])
    possible_moves << [y + s2[0], x + s2[1]] if enemy_piece?([y + s2[0], x + s2[1]])
    possible_moves
  end
end