require_relative 'deck'
require_relative 'player'
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
    until game_over?
      play_round
      reset_all
    end
  end

  def reset_all
    @players.each do |player|
      player.pot > 1 ? player.unfold : player.fold
      @deck.take_cards(player.hand.cards)
      player.hand.cards = []
      @deck.shuffle!
    end
  end

  def game_over?
    remaining_players = @players.select { |player| player.pot > 1 }
    if remaining_players.length == 0
      puts 'Thanks for... tossing money in and never cashing out?'
    elsif remaining_players.length == 1
      puts "#{remaining_players[0].name} walking away with ALL your money!"
    end
    remaining_players.length < 2
  end

  def play_round
    deal_cards
    players_bet
    players_discard
    deal_cards
    players_bet
    award_winners
  end

  def award_winners
    remaining_players = @players.select { |player| !player.folded? }
    case remaining_players.length
    when 0
      nil
    when 1
      award_pot(remaining_players)
    else
      winners = strongest_hand(remaining_players)
      award_pot(winners)
    end
  end

  def strongest_hand(players)
    winners = [players.first]
    strongest = players.first
    players[1..-1].each do |player|
      if player.hand > strongest.hand
        winners = [player]
        strongest = player
      elsif player.hand == strongest.hand
        winners << player
      end
    end
    winners
  end

  def award_pot(winners)
    split = @game_pot / winners.length
    winners.each do |winner|
      puts "#{winner.name} won #{split} dollars!"
      winner.pot += split
    end
    @game_pot = 0
  end

  def show_current_pot(player)
    puts "There is #{@game_pot} dollars in the game pot! And you have #{player.pot} dollars left to bet with."
  end


  def players_bet
    @players.each { |player| play_bet(player) unless player.folded? }
  end

  def play_bet(player)
    player.show_hand
    input = nil
    until %w[f r].include?(input)
      input = player.get_action_input
      show_current_pot(player) if input == 'b'
    end
    
    case input
    when 'f'
      puts "#{player.name} has folded!"
      player.fold
    when 'r'
      @game_pot += player.raise
      puts "#{player.name} raised pot by 1 dollar! Pot is now #{@game_pot}."
    end
  end

  def players_discard
    @players.each { |player| play_discard(player) unless player.folded? }
  end

  def play_discard(player)
    player.show_hand
    input = player.get_discard_input
    discarded = player.discard_cards(input)
    @deck.take_cards(discarded)
  end

  def deal_cards
    @players.each do |player|
      amount = 5 - player.cards_in_hand
      player.take_cards(@deck.deal(amount))
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  players = ['Ted', 'Helen', 'Brian', 'Poitier']
  g = Game.new(*players)
  g.play
end
