require_relative "room"

class Hotel
  attr_reader :rooms

  def initialize(name, rooms)
    @name = name
    rooms.each { |k, v| rooms[k] = Room.new(v) }
    @rooms = rooms
  end

  def name
    @name.split(' ').map(&:capitalize).join(' ')
  end

  def room_exists?(room_name)
    rooms.has_key? room_name
  end
  
  def check_in(person, room_name)
    if room_exists?(room_name) 
      print rooms[room_name].add_occupant(person) ? 'check in successful' : 'sorry, room is full'
    else
      print 'sorry, room does not exist'
    end
  end
  
  def has_vacancy?
    rooms.any? { |_, room| !(room.full?) }
  end

  def list_rooms
    rooms.each { |room_name, room| puts "#{room_name} #{room.available_space}" }
  end
end
