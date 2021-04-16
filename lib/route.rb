require_relative 'instance_counter.rb'

class Route
  include InstanceCounter
  
  attr_accessor :stations

  def initialize(stations = [])
    self.stations = stations
    
    self.class.add_instance(self)
  end

  def add_station(adding, possition = 1)
    stations.insert(possition, adding)
  end

  def del_station(removing)
    stations.delete(removing)
  end

  def route_reverse
    stations.reverse!
  end

  def origination
    stations.first
  end

  def destination
    stations.last
  end

  def station_titles
    titles = []
    stations.each { |x| titles << x.title }
    titles
  end
end
