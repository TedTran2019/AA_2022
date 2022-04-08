class Passenger
  attr_reader :name

  def initialize(name)
    @name = name
    @flight_numbers = []
  end

  def has_flight?(flight_nbr)
    @flight_numbers.include?(flight_nbr.upcase)
  end

  def add_flight(flight_nbr)
    @flight_numbers << flight_nbr.upcase unless has_flight?(flight_nbr)
  end
end
