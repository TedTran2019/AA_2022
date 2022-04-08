require_relative 'board'
require_relative 'human_player'

class Game
  attr_reader :current_player

  def initialize(p1_mark, p2_mark)
    @p1 = HumanPlayer.new(p1_mark)
    @p2 = HumanPlayer.new(p2_mark)
    @board = Board.new
    @current_player = @p1
  end

  def switch_turn
    @current_player = (current_player == @p1 ? @p2 : @p1) 
  end

  def play
    while @board.empty_positions?
      @board.print_board
      pos = @current_player.get_position
      @board.place_mark(pos, current_player.mark)
      if @board.win?(current_player.mark)
        @board.print_board
        puts "#{current_player.mark} has won!"
        return true
      end
      switch_turn
    end
    @board.print_board
    puts "Draw game!"
  end
end