# n^2
def sluggish_octopus(fishes)
  return fishes.first if fishes.length < 2

  (0...fishes.length).each do |y|
    greatest_fish = true
    (0...fishes.length).each do |x|
      greatest_fish = false if fishes[y].length < fishes[x].length
    end
    return fishes[y] if greatest_fish
  end
end

# nlogn
def dominant_octopus(fishes)
  fishes.sort { |a, b| a.length <=> b.length }[-1]
end

# n
def clever_octopus(fishes)
  return fishes.first if fishes.length < 2

  largest_fish = fishes.first
  (1...fishes.length).each do |x|
    largest_fish = fishes[x] if fishes[x].length > largest_fish.length
  end
  largest_fish
end

# n
def slow_dance(dir, tiles_array)
  tiles_array.each_with_index { |tile, i| return i if tile == dir }
end

# 1
def constant_dance(dir, tiles_dict)
  tiles_dict[dir]
end

p sluggish_octopus(['fish', 'fiiish', 'fiiiiish', 'fiiiish', 'fffish', 'ffiiiiisshh', 'fsh', 'fiiiissshhhhhh'])
p dominant_octopus(['fish', 'fiiish', 'fiiiiish', 'fiiiish', 'fffish', 'ffiiiiisshh', 'fsh', 'fiiiissshhhhhh'])
p clever_octopus(['fish', 'fiiish', 'fiiiiish', 'fiiiish', 'fffish', 'ffiiiiisshh', 'fsh', 'fiiiissshhhhhh'])
tiles_array = ["up", "right-up", "right", "right-down", "down", "left-down", "left",  "left-up" ]
tiles_dict = {}
tiles_array.each_with_index { |dir, i| tiles_dict[dir] = i }
p slow_dance('up', tiles_array)
p slow_dance('right-down', tiles_array)
p constant_dance('up', tiles_dict)
p constant_dance('right-down', tiles_dict)
