require_relative 'board'
require_relative 'tile'

class Game
  def initialize(file)
    @board = Board.new(Board.from_file(file))
  end

  def play
    play_round until @board.solved?
    puts "You win!"
  end

  def play_round
    @board.render
    y, x, val = get_input
    @board[[y, x]] = val
    @board.render
  end

  def prompt
    puts 'Enter like this: row col value'
  end

  def get_input
    input = false
    until input
      prompt
      input = gets.chomp.split(' ')
      unless valid_input?(input)
        input = false
        next
      end
      input[0], input[1] = input[0].to_i, input[1].to_i
      input = false if @board[[input[0], input[1]]].given
    end
    input
  end

  def valid_input?(input)
    input.length == 3 &&
      input.all? { |str| str.length == 1 } &&
      input[0].between?('0', '8') &&
      input[1].between?('0', '8') &&
      input[2].between?('0', '9')
  end
end

folder = 'puzzles/'
files = ['sudoku1', 'sudoku1_solved', 'sudoku3', 'sudoku1_almost', 'sudoku2']
ext = '.txt'
g = Game.new(folder + files[3] + ext)
g.play