def is_prime?(nbr)
  return false if nbr < 2
  (2...nbr).none? { |n| (nbr % n).zero? }
end

def nth_prime(n)
  counter = 0
  nbr = 2
  while nbr
    counter += 1 if is_prime?(nbr)
    return nbr if counter == n
    nbr += 1
  end
end

def prime_range(min, max)
  (min..max).select { |n| is_prime?(n) }
end