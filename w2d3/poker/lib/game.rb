class Game
  def initialize(*player_names)
    raise "Can't play poker alone!" unless player_names.length > 1
  
    @deck = Deck.new
    @players = player_names.map { |name| Player.new(name) }
    @game_pot = 0
    @current_player = 0
  end

  def next_player!
    @current_player = (@current_player + 1) % @players.length
  end

  def current_player
    @players[@current_player]
  end
end