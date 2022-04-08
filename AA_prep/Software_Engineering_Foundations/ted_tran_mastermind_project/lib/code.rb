class Code
  POSSIBLE_PEGS = {
    "R" => :red,
    "G" => :green,
    "B" => :blue,
    "Y" => :yellow
  }

  def self.valid_pegs?(pegs)
    pegs.all? { |peg| POSSIBLE_PEGS.include? peg.upcase }
  end

  def self.random(length)
    code = []
    length.times { code << POSSIBLE_PEGS.keys.sample }
    Code.new(code)
  end

  def self.from_string(pegs)
    pegs_arr = pegs.split('')
    Code.new(pegs_arr) if Code.valid_pegs?(pegs_arr)
  end

  attr_reader :pegs

  def initialize(pegs)
    raise 'Invalid pegs' unless Code.valid_pegs?(pegs)

    @pegs = pegs.map(&:upcase)
  end

  def [](idx)
    pegs[idx]
  end

  def length
    pegs.length
  end

  def num_exact_matches(guess)
    exact = 0
    (0...length).each { |i| exact += 1 if guess.pegs[i] == pegs[i] }
    exact
  end

  def num_near_matches(guess)
    near = 0
    guess_dict = Hash.new { |k, v| k[v] = 0 }
    code_dict = Hash.new { |k, v| k[v] = 0 }
    guess.pegs.each { |peg| guess_dict[peg] += 1 }
    pegs.each { |peg| code_dict[peg] += 1 }
    guess_dict.each do |k, v|
      if code_dict[k] >= guess_dict[k]
        near += guess_dict[k]
      else
        near += code_dict[k]
      end
    end
    near - num_exact_matches(guess)
  end

  def ==(code)
    code.pegs == pegs
  end
end
