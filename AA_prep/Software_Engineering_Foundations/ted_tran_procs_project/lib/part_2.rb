def reverser(str, &prc)
  prc.call(str.reverse)
end

def word_changer(str, &prc)
  str.split(' ').map { |word| prc.call(word) }.join(' ')
end

def greater_proc_value(nbr, prc1, prc2)
  val1 = prc1.call(nbr) 
  val2 = prc2.call(nbr)
  val1 > val2 ? val1 : val2
end

def and_selector(arr, prc1, prc2)
  arr.select { |nbr| prc1.call(nbr) && prc2.call(nbr) }
end

def alternating_mapper(arr, prc1, prc2)
  arr.map.with_index { |nbr, i| i.even? ? prc1.call(nbr) : prc2.call(nbr) }
end