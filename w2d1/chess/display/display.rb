require 'colorize'
require_relative 'cursor'
# require_relative '../board'

class Display
  def initialize(board)
    @board = board
    @cursor = Cursor.new([0, 0], board)
  end

  def test
    while 1
      render
      @cursor.get_input
    end
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
  end
end