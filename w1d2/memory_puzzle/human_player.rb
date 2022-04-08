class HumanPlayer
  def initialize(size)
    @size = size
  end

  def get_input
    puts 'Make a guess in this format: y x'
    gets.chomp.split(' ').map(&:to_i)
  end

  def give_ai_info(face, pos)
  end
end
