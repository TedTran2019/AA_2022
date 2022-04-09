require 'colorize'
class Tile

  attr_accessor :neighbor_bomb_count

  def initialize(bomb)
    @bomb = bomb
    @flag = false
    @revealed = false
    @neighbor_bomb_count = nil
  end

  def bomb?
    @bomb
  end

  def bomb_revealed?
    @bomb && @revealed
  end

  def flagged?
    @flag
  end

  def flag
    @flag = !@flag
  end

  def revealed?
    @revealed
  end

  def reveal
    @revealed = true
  end

  def to_s
    if revealed?
      output_revealed 
    else
      output_hidden
    end
  end

  def inspect
    "B:#{bomb?},R:#{revealed?}, N:#{neighbor_bomb_count}\n"
  end

  def output_revealed
    if bomb?
      'B'.colorize(:red)
    elsif neighbor_bomb_count.zero?
      '_'
    else
      neighbor_bomb_count.to_s.colorize(:blue)
    end
  end

  def output_hidden
    if flagged?
      'F'.colorize(:green)
    else
      '*'
    end
  end
end