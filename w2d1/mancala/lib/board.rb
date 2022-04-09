class Board
  attr_accessor :cups

  def initialize(name1, name2)
    @p1 = name1 # Idx 6
    @p2 = name2 # Idx 13
    @cups = Array.new(14) { Array.new }
    place_stones
  end

  def place_stones
   (0...6).each { |el| 4.times { cups[el] << :stone }}
   (7...13).each { |el| 4.times { cups[el] << :stone }}
  end

  def valid_move?(start_pos)
    raise 'Invalid starting cup' if start_pos < 0 || start_pos > (@cups.length - 1)
    raise 'Starting cup is empty' if @cups[start_pos].empty?
  end

  def make_move(start_pos, current_player_name)
    hand = @cups[start_pos].dup
    @cups[start_pos] = []
    until hand.empty?
      start_pos = (start_pos + 1) % 14
      case start_pos
      when 6
        add_stone(start_pos, hand) if @p1 == current_player_name
      when 13
        add_stone(start_pos, hand) if @p2 == current_player_name
      else
        add_stone(start_pos, hand)
      end
    end
    render
    next_turn(start_pos)
  end

  def add_stone(i, hand)
    @cups[i] << hand.pop
  end

  def next_turn(ending_cup_idx)
    if ending_cup_idx == 6 || ending_cup_idx == 13
      :prompt
    elsif @cups[ending_cup_idx].length == 1
      :switch
    else
      ending_cup_idx
    end
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
    (0...6).all? { |i| @cups[i].empty? } || (7...13).all? { |i| @cups[i].empty? }
  end

  def winner
    return :draw if @cups[6].length == @cups[13].length

    @cups[6].length > @cups[13].length ? @p1 : @p2
  end
end
