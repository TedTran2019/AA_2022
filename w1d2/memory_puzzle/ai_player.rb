class AiPlayer
  def initialize(size)
    @known_cards = Hash.new { |h, k| h[k] = [] }
    @size = size
    @positions = generate_positions.shuffle
    @matched_cards = []
    @previous_two = []
  end

  def get_input
    if @previous_two.length == 2
      x, y = @previous_two
      reversed_two = [y, x]
      @known_cards.delete_if { |k, v| v == @previous_two || v == reversed_two } 
      @previous_two = []
    end
    puts 'Make a guess in this format: y x'
    input = lol_input
    @previous_two << input
    p input
    # sleep(1)
    input
  end

  def lol_input
    find_matches
    if @matched_cards.empty?
      @positions.pop
    else
      pick_matched_card
    end
  end

  def pick_matched_card
    @matched_cards[0].each { |pos| return pos unless @previous_two.include?(pos) }
  end

  def flip_guess
    @first_guess = !@first_guess
  end

  def find_matches
    matches = []
    @known_cards.each { |k, v| matches << v if v.length == 2 }
    @matched_cards = matches
  end

  def give_ai_info(face, pos)
    @known_cards[face] << pos unless @known_cards[face].length == 2
  end

  def generate_positions
    positions = []
    (0...@size).each do |y|
      (0...@size).each do |x|
        positions << [y, x]
      end
    end
    positions
  end
end
