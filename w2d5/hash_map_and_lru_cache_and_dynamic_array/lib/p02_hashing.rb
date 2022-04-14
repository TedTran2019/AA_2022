class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    hashed = 1337
    self.each_with_index { |el, i| hashed ^= el.hash + (i * 1337)}
    hashed
  end
end

class String
  def hash
    hashed = 1337
    self.each_char.with_index { |c, i| hashed ^= c.ord.hash + (i * 1337) }
    hashed
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    hashed = 1337
    self.each { |k, v| hashed ^= k.hash * v.hash }
    hashed
  end
end
