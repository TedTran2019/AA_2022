class Game
  def initialize(*player_names)
    raise "Can't play poker alone!" unless player_names.length > 1
    raise "No more than 4 players!" if player_names.length > 4
  
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

  def play
  end

  def play_round
    deal_cards
    
  end

  def deal_cards
    @players.each do |player|
      player.take_cards(@deck.deal(5))
    end
  end
end