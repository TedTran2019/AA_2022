class Item
  def self.valid_date?(date)
    date_arr = date.split('-').map(&:to_i)
    date_arr.length == 3 && date_arr[0] > 999 &&
    date_arr[1].between?(1, 12) && date_arr[2].between?(1, 31)
  end

  attr_accessor :title, :description
  attr_reader :deadline, :done

  def initialize(title, deadline, description)
    raise 'Date invalid' unless Item.valid_date?(deadline)

    @title = title
    @deadline = deadline
    @description = description
    @done = false
  end

  def deadline=(new_deadline)
    @deadline = new_deadline if Item.valid_date?(new_deadline)
  end

  def toggle
    @done = (@done ? false : true)
  end
end
