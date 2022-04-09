require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    current_state = TicTacToeNode.new(game.board, mark)
    possible_states =  current_state.children
    possible_states.each do |state|
      return (state.prev_move_pos) if state.winning_node?(mark)
    end
    possible_states.each do |state|
      return state.prev_move_pos unless state.losing_node?(mark)
    end
    raise 'NANI? How did I not win or draw? Impossible!'
  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
