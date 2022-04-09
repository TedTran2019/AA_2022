require_relative 'board'
require 'yaml'
class Game
  def initialize(size)
    @board = Board.create_board(size)
    @lost = false
  end

  def play_round
    non_play = %w[s l]
    @board.render
    flag = get_flag_input
    pos = get_pos_input(flag) unless non_play.include?(flag)
    action(flag, pos)
  end

  def action(flag, pos = nil)
    case flag
    when 'r'
      reveal(pos)
    when 'f'
      @board[pos].flag
    when 's'
      save_game
    when 'l'
      load_game
    end
  end

  def save_game
    File.open('saved_games/game.yml', 'w') { |file| file.write(@board.to_yaml) }
    puts 'Game saved!'
  end

  def load_game
    board = YAML.load(File.read('saved_games/game.yml'))
    if board
      @board = board
      puts 'Game loaded from save!'
    else
      puts 'No game saved! Save a game first before using load.'
    end
  end

  def run
    play_round until game_over?
    @board.render
    puts "Hope you enjoyed playing Minesweeper!"
  end

  def game_over?
    @lost || won?
  end

  def won?
    @board.won?
  end

  def reveal(pos)
    return nil unless @board.between_bounds?(*pos) && !@board[pos].revealed?

    @board[pos].reveal
    @board[pos].flag if @board[pos].flagged?
    (@lost = true) && (return nil) if @board[pos].bomb?
    return nil unless @board[pos].neighbor_bomb_count.zero?

    Board::ALL_DIRS.each do |d_pos|
      dy, dx = d_pos
      dy += pos[0]
      dx += pos[1]
      reveal([dy, dx])
    end
  end

  def get_flag_input
    flag = nil
    until flag && valid_flag?(flag)
      prompt_flag
      flag = gets.chomp
      flag = (valid_flag?(flag) ? flag : nil)
    end
    flag
  end

  def get_pos_input(flag)
    pos = nil
    until pos && valid_pos?(pos, flag)
      prompt_pos
      pos = gets.chomp.split(' ').map(&:to_i)
      pos = (valid_pos?(pos, flag) ? pos : nil)
    end
    pos
  end

  def prompt_flag
    puts 'Enter a flag [r, f, s, l] like this: r'
  end

  def prompt_pos
    puts 'Enter pos like this: row column'
  end

  def valid_flag?(flag)
    valid = %w[r f s l]
    if valid.include?(flag)
      true
    else
      puts 'Invalid flag! Options: [r, f, s, l]'
      false
    end
  end

  def valid_pos?(pos, flag)
    return false unless pos.length == 2 &&
                        @board.between_bounds?(*pos) &&
                        !@board[pos].revealed?
    return false if flag == 'r' && @board[pos].flagged?
  
    true
  end
end

if __FILE__ == $PROGRAM_NAME
  g = Game.new(9)
  g.run
end