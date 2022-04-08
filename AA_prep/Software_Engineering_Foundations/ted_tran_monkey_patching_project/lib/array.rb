# Monkey-Patch Ruby's existing Array class to add your own custom methods
class Array
  def span
    self.empty? ? nil : self.max - self.min
  end

  def average
    self.empty? ? nil : self.sum / (self.length * 1.0)
  end

  def median
    return nil if self.empty?
  
    sorted = self.sort
    mid_idx = self.length / 2
    self.length.even? ? (sorted[mid_idx] + sorted[mid_idx - 1]) / 2.0 : sorted[mid_idx]
  end

  def counts
    dict = Hash.new { |h, k| h[k] = 0 }
    self.each { |ele| dict[ele] += 1 }
    dict
  end

  def my_count(val)
    self.inject(0) { |accu, ele| ele == val ? accu + 1 : accu }
  end

  def my_index(val)
    self.each_with_index { |el, i| return i if el == val }
    nil
  end

  def my_uniq
    dict = {}
    self.each { |el| dict[el] = 1 }
    dict.keys
  end

  def my_transpose
    transposed = []
    self.each_with_index do |_, x|
      tmp = []
      self.each_with_index do |_, y|
        tmp << self[y][x]
      end
      transposed << tmp
    end
    transposed
  end
end
