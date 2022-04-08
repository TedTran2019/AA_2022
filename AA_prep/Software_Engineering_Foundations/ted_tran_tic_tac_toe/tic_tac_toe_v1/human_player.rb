class HumanPlayer
  attr_reader :mark

  def initialize(mark)
    @mark = mark
  end

  def get_position
    puts "Enter in this format: 'row column'"
    input = gets.chomp.split(' ')
    raise 'Invalid' unless input.length == 2 && input.all? { |nbr| nbr !~ /\D/ }
    input.map(&:to_i)
  end
end