class Route
  attr_reader :first, :last, :intermediate_stations
  def initialize(first, last, *intermediate_stations)
    @first, @last = first, last
    @intermediate_stations = intermediate_stations
  end
  
  def add_station(adding, possition = 1)
    @intermediate_stations.insert(possition, adding)
  end
  
  def del_station(removing)
    @intermediate_stations.delete(removing)
  end
  
  def stations
    [first, *intermediate_stations, last]
  end
end
