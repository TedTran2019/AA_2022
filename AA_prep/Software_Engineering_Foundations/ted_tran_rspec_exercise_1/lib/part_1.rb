def average(nbr1, nbr2)
  (nbr1 + nbr2) / 2.0
end

def average_array(arr)
  arr.sum / (arr.length * 1.0)
end

def repeat(str, nbr)
  str * nbr
end

def yell(str)
  str.upcase + '!'
end

def alternating_case(str)
  str.split(' ').map.with_index { |word, i| i.even? ? word.upcase : word.downcase }
  .join(' ')
end

