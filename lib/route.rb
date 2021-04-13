class Route
  attr_accessor :stations

  def initialize(stations = [])
    self.stations = stations
  end

  def add_station(adding, possition = 1)
    self.stations.include?(adding)
    self.stations.insert(possition, adding)
    self.stations.include?(adding)
  end

  def del_station(removing)
    self.stations.include?(removing)
    self.stations.delete(removing)
    self.stations.include?(removing)
  end

  def route_reverse
    self.stations.reverse!
  end

  def origination
    self.stations.first
  end
  
  def destination
    self.stations.last
  end
  
  def station_titles
    titles = []
    self.stations.each { |x| titles << x.title}
    titles
  end
end