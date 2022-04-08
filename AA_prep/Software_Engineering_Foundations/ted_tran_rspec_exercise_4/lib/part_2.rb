def proper_factors(nbr)
  (1...nbr).select { |n| (nbr.fdiv(n)) - (nbr / n) == 0}
end

def aliquot_sum(n)
  proper_factors(n).sum
end

def perfect_number?(n)
  aliquot_sum(n) == n
end

def ideal_numbers(n)
  arr = []
  nbr = 1
  while nbr
    return arr if arr.length == n
    arr << nbr if perfect_number?(nbr)
    nbr += 1
  end
end
