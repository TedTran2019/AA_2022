require_relative 'board'

class Game
  def initialize(size)
    @board = Board.create_board(size)
  end

  def play_round
    @board.render
    flag = get_flag_input
    pos = get_pos_input(flag)
    action(flag, pos)
  end

  def action(flag, pos = nil)
    case flag
    when 'r'
      @board[pos].reveal
    when 'f'
      @board[pos].flag
    end
  end

  def run
    play_round until game_over?
    @board.render
    puts "Hope you enjoyed playing Minesweeper!"
  end

  def game_over?
    lost? || won?
  end

  def lost?
    @board.lost?
  end

  def won?
    @board.won?
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
    puts 'Enter a flag [r, f] like this: r'
  end

  def prompt_pos
    puts 'Enter pos like this: row column'
  end

  def valid_flag?(flag)
    case flag
    when 'r'
      true
    when 'f'
      true
    else
      puts 'Invalid flag! Options: [r, f]'
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
  g = Game.new(4)
  g.run
end