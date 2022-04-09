require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
   return (opponent(evaluator) == board.winner) if board.over? 
    possible_moves = children
    if evaluator == next_mover_mark
      possible_moves.all? { |move| move.losing_node?(evaluator) }
    else
      possible_moves.any? { |move| move.losing_node?(evaluator) }
    end
  end

  def opponent(mark)
    mark == :o ? :x : :o
  end

  def winning_node?(evaluator)
    return (evaluator == board.winner) if board.over?
    possible_moves = children
    if evaluator == next_mover_mark
      possible_moves.any? { |move| move.winning_node?(evaluator) }
    else
      possible_moves.all? { |move| move.winning_node?(evaluator) }
    end
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  # Board already has dup defined
  # [x, y] instead of [y, x]
  def children
    possible_moves = []
    (0...3).each do |y|
      (0...3).each do |x|
        pos = [x, y]
        next unless @board.empty?(pos)

        copy = @board.dup
        copy[pos] = @next_mover_mark
        new_mark = (@next_mover_mark == :o ? :x : :o)
        move = TicTacToeNode.new(copy, new_mark, pos)
        possible_moves << move
      end
    end
    possible_moves
  end
end
