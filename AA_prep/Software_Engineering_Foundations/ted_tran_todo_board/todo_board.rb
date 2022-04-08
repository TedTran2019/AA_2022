require_relative 'list.rb'

class TodoBoard
  def initialize
    @lists = {}
  end

  def get_command
    puts 'Enter a command!'
    cmd, label, *args = gets.chomp.split(' ')
    case cmd
    when 'mklist'
      @lists[label] = List.new(label)
    when 'ls'
      p @lists.keys
    when 'showall'
      @lists.each { |k, v| v.print }
    when 'mktodo'
      @lists[label].add_item(*args)
    when 'up'
      @lists[label].up(*args.map { |i| i.to_i })
    when 'down'
      @lists[label].down(*args.map { |i| i.to_i })
    when 'swap'
      @lists[label].swap(*args.map { |i| i.to_i })
    when 'sort'
      @lists[label].sort_by_date!
    when 'priority'
      @lists[label].print_priority
    when 'print'
      args.length.zero? ? @lists[label].print : @lists[label].print_full_item(args[0].to_i)
    when 'toggle'
      @lists[label].toggle_item(args[0].to_i)
    when 'rm'
      @lists[label].remove_item(args[0].to_i)
    when 'purge'
      @lists[label].purge
    when 'quit'
      return false
    else
      puts 'Sorry, that command is not recognized.'
    end
    true
  end

  def run
    while get_command
    end
  end
end

b = TodoBoard.new
b.run