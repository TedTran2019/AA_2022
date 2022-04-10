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
    movement = at_start_row?(@pos[0]) ? 2 : 1
    possible_moves = []
    y, x = pos
    movement.times do 
      y += forward_dir
      possible_moves << [y, x] unless @board.out_of_bounds?(y, x) || @board.space_taken?([y, x])
      break if @board.space_taken?([y, x])
    end
    possible_moves.concat(side_attacks)
  end

  def side_attacks
    possible_moves = []
    y, x = pos
    d_pos = [[forward_dir, 1], [forward_dir, -1]]
    d_pos.each do |change|
      dy, dx = change
      dy += y
      dx += x
      next if @board.out_of_bounds?(dy, dx)
      possible_moves << [dy, dx] if enemy_piece?([dy, dx])
    end
    possible_moves
  end
end