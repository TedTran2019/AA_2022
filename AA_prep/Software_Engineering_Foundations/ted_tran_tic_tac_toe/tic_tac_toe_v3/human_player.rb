class HumanPlayer
  attr_reader :mark

  def initialize(mark)
    @mark = mark
  end

  def get_position(legal_positions)
    while 1
      puts "Enter in this format: 'row column'"
      input = gets.chomp.split(' ').map(&:to_i)
      return input if legal_positions.include?(input)
      puts "#{input} is not a legal option"
    end
  end
end