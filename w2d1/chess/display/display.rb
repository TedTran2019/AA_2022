require 'colorize'
require_relative 'cursor'
# require_relative '../board'

class Display
  attr_reader :cursor
  
  def initialize(board)
    @board = board
    @cursor = Cursor.new([0, 0], board)
  end

  def render
    system('clear')
    color = @cursor.selected ? :red : :green
    @board.grid.each_with_index do |row, y|
      row.each_with_index do |ele, x| 
        if [y, x] == @cursor.cursor_pos 
          print "#{ele.to_s.colorize(color)} "
        else
          print "#{ele} "
        end
      end
      print "\n"
    end
    if @cursor.debug && @board[@cursor.cursor_pos].class != NullPiece
      print @board[@cursor.cursor_pos].valid_moves
      print "\n"
    end
  end
end
