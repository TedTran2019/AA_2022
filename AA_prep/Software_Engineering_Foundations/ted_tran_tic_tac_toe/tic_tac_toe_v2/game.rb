require_relative 'board'
require_relative 'human_player'

class Game
  attr_reader :current_player

  def initialize(board_size, *marks)
    @players = marks.map { |mark| HumanPlayer.new(mark)}
    @board = Board.new(board_size)
    @current_player = 0
  end

  def switch_turn
    @current_player = (@current_player + 1) % @players.length
  end

  def play
    while @board.empty_positions?
      @board.print_board
      mark = @players[current_player].mark
      pos = @players[@current_player].get_position
      @board.place_mark(pos, mark)
      if @board.win?(mark)
        @board.print_board
        puts "#{mark} has won!"
        return true
      end
      switch_turn
    end
    @board.print_board
    puts "Draw game!"
  end
end