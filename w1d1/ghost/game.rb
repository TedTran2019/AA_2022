require_relative 'player.rb'

class Game
  GHOST_STR = 'GHOST'

  def self.parse_dict(file)
    dict = {}
    File.foreach(file) { |line| dict[line.chomp] = true }
    dict
  end

  def initialize(dictionary, *players)
    @dictionary = dictionary
    @players = players
    @current_player = 0
    @previous_player = nil
    @fragment = ''
    @losses = losses_hash
  end

  def run
    play_round until @players.length == 1
    display_standings
    puts "#{current_player.name} has won the game!"
  end

  private

  def dictionary
    @dictionary.keys
  end

  def play_round
    display_standings
    puts "Fragment is: '#{@fragment}'"
    take_turn
    if round_lost?
      tally_loss
      reset_fragment
    end
    next_player!
  end

  def loss_message
    if @losses[previous_player] == 5
      puts "#{previous_player.name} is booted from the game!"
      true
    else
      puts "#{previous_player.name} has taken a strike!"
      false
    end
  end

  def kick_player
    current = current_player
    @players.delete_if { |player| player == previous_player }
    @current_player -= 1 unless current == current_player
  end

  def tally_loss
    @losses[previous_player] += 1
    kick_player if loss_message
  end

  def reset_fragment
    @fragment = ''
  end

  def current_player
    @players[@current_player]
  end

  def previous_player
    raise 'There was no previous player, this is the first round!' if @previous_player.nil? 
    @players[@previous_player]
  end

  def next_player!
    @previous_player = @current_player
    @current_player = (@current_player + 1) % @players.length
  end

  def take_turn
    valid_input = false
    until valid_input
      valid_input = current_player.guess
      next unless valid_input
      unless valid_play?(@fragment + valid_input)
        valid_input = false
        puts "This letter doesn't build towards any word!"
      end
    end
    @fragment << valid_input
    puts "#{current_player.name} guesses '#{valid_input}' creating: #{@fragment}"
  end

  def round_lost?
    @dictionary.key?(@fragment)
  end

  def valid_play?(str)
    @dictionary.keys.any? { |word| word.start_with?(str) }
  end

  def losses_hash
    losses = {}
    @players.each { |player| losses[player] = 0 } 
    losses
  end

  def record(player)
    puts GHOST_STR[0...@losses[player]].rjust(5, '_')
  end

  def display_standings
    @players.each { |player| "#{player.name}: #{record(player)}" }
  end
end

dict = Game.parse_dict('dictionary.txt')
p1 = Player.new('Ted')
p2 = Player.new('Helen')
p3 = Player.new('Brian')
game = Game.new(dict, p1, p2, p3)

if __FILE__ == $PROGRAM_NAME
  game.run
end