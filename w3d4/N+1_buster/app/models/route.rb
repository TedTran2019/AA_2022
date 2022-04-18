class Route < ApplicationRecord
  has_many :buses,
    class_name: 'Bus',
    foreign_key: :route_id,
    primary_key: :id

  def n_plus_one_drivers
    buses = self.buses

    all_drivers = {}
    buses.each do |bus|
      drivers = []
      bus.drivers.each do |driver|
        drivers << driver.name
      end
      all_drivers[bus.id] = drivers
    end

    all_drivers
  end

  def better_drivers_query
    data = Bus.find_by_sql ["
    SELECT
      buses.id, drivers.name
    FROM
      routes
    JOIN
      buses ON routes.id = buses.route_id
    JOIN
      drivers ON buses.id = drivers.bus_id
    WHERE
      routes.id = ?
    GROUP BY
      buses.id, drivers.name
    ", id]
    info = Hash.new { |h, k| h[k] = [] }
    data.each { |datum| info[datum['id']] << datum['name'] }
    info
  end
end
