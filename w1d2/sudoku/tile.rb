require 'colorize'

class Tile
  attr_reader :given
  attr_accessor :value
  
  def initialize(value, given)
    @value = value
    @given = given
  end

  def to_s
    if @value == '0'
      '_ '
    elsif @given == false
      "#{@value.colorize(:red)} "
    else
      "#{@value} ".colorize(:green)
    end
  end
end