class Route
  attr_reader :origination, :destination, :intermediate_stations
  
  def initialize(stations)
    self.origination = stations.first
    self.destination = stations.last
    stations.pop
    stations.shift
    self.intermediate_stations = stations
  end

  def add_station(adding, possition = 1)
    self.intermediate_stations.insert(possition, adding)
  end

  def del_station(removing)
    self.intermediate_stations.delete(removing)
  end

  def stations
    [self.origination, self.intermediate_stations, self.destination].flatten
  end
  
  def route_reverse(stations)
    self.initialize(stations)
  end
  private #согласно заданию №1 начало и конец пути сменить нельзя, а для добавления и удаления станций существуют соответствующие методы
  attr_writer :origination, :destination, :intermediate_stations
end
