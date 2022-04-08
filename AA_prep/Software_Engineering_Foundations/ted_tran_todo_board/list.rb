require_relative 'item.rb'

class List
  attr_accessor :label

  def initialize(label)
    @label = label
    @items = []
  end

  def add_item(title, deadline, description = '')
    item = Item.new(title, deadline, description) if Item.valid_date?(deadline)
    @items << item if item
    item ? true : false
  end

  def size
    @items.size
  end

  def valid_index?(idx)
    idx > -1 && idx < size
  end

  def swap(idx1, idx2)
    if valid_index?(idx1) && valid_index?(idx2)
      @items[idx1], @items[idx2] = @items[idx2], @items[idx1]
      true
    else
      false
    end
  end

  def [](idx)
    valid_index?(idx) ? @items[idx] : nil
  end

  def priority
    @items.first
  end

  def print
    puts "-" * 55
    puts "#{label}".rjust(30)
    puts "-" * 55
    puts 'Index | ' + 'Item'.ljust(22) + '| Deadline'.ljust(13) + '| Done'
    puts "-" * 55
    @items.each_with_index { |item, i| puts "#{i}".ljust(5) + " | " + 
                                            "#{item.title}".ljust(22) + 
                                            "| #{item.deadline}" + ' | ' + 
                                            (item.done ? '[x]' : '[ ]')}
    puts "-" * 55
  end

  def print_full_item(idx)
    return nil unless valid_index?(idx)
  
    item = self[idx]
    puts '-' * 45
    puts "#{item.title}".ljust(30) + " #{item.deadline}" + (item.done ? ' [x]' : ' [ ]')
    puts item.description
    puts '-' * 45
  end

  def print_priority
    print_full_item(0) unless size.zero?
  end

  def up(idx, amount = 1)
    return false unless valid_index?(idx)
    swaps = 0
    until (swaps == amount) || (idx.zero?)
      swap(idx, idx - 1)
      swaps += 1
      idx -= 1
    end
    true
  end

  def down(idx, amount = 1)
    return false unless valid_index?(idx)
    swaps = 0
    until (swaps == amount) || (idx == (size - 1))
      swap(idx, idx + 1)
      swaps += 1
      idx += 1
    end
    true
  end

  def sort_by_date!
    @items.sort_by! { |item| item.deadline }
  end

  def toggle_item(idx)
    return false unless valid_index?(idx)

    self[idx].toggle
    true
  end

  def remove_item(idx)
    return false unless valid_index?(idx)

    @items.delete_at(idx)
    true
  end

  def purge
    new_list = []
    @items.each { |item| new_list << item unless item.done }
    @items = new_list
  end
end
