class Array
  def my_uniq
    new_arr = []
    dict = {}
    self.each do |el|
      unless dict.key?(el)
        dict[el] = true
        new_arr << el
      end
    end
    new_arr
  end

  def two_sum
    sum_pos = []
    dict = {}
    self.each_with_index do |n, i|
      sum_pos.unshift [dict[n], i] if dict.key?(n)
      dict[0 - n] = i
    end
    sum_pos
  end

  def my_transpose
    return self if self.empty?
    transposed = []
    (0...(self[0].length)).each do |x|
      sub_arr = []
      (0...self.length).each do |y|
        sub_arr << self[y][x]
      end
      transposed << sub_arr
    end
    transposed
  end
end

def stock_picker(prices)
  profit = []
  profit_max = 0
  prices.each_with_index do |buy, y|
    break if y == (prices.length - 1)

    ((y + 1)...prices.length).each do |x|
      new_profit = prices[x] - buy
      if new_profit == profit_max
        profit << [y, x]
      elsif new_profit > profit_max
        profit = [[y, x]]
        profit_max = new_profit
      end
    end
  end
  profit
end

class TowersOfHanoi
  attr_reader :stack1, :stack2, :stack3, :nbr_discs

  def initialize
    @stack1 = [3, 2, 1]
    @stack2 = []
    @stack3 = []
    @stacks = [@stack1, @stack2, @stack3]
    @nbr_discs = 3
  end

  def play_round
    render
    puts 'pick_disc place_disc'
    pos = get_input
    move(pos)
  rescue RuntimeError => e
    puts e.message
    retry
  end

  def get_input
    input = nil
    until input and valid_input?(input)
      input = gets.chomp.split(' ').map(&:to_i)
    end
    input
  end

  def valid_input?(input)
    input.length == 2 &&
      input.all? { |idx| idx.is_a?(Integer) && idx.between?(0, 2)}

  end

  def render
    @stacks.each { |stack| print "#{stack}\n" }
  end

  def play
    play_round until won?
    render
    puts "You've won!"
  end

  def move(pos)
    start_idx, end_idx = pos
    raise "Can't take from empty stack!" if @stacks[start_idx].empty?
    raise "Can't place onto smaller disc!" unless @stacks[end_idx].empty? ||
                                          @stacks[start_idx].last < @stacks[end_idx].last

    @stacks[end_idx] << @stacks[start_idx].pop
  end

  def won?
    @stack2.length == 3 || @stack3.length == 3
  end
end

# g = TowersOfHanoi.new
# g.play