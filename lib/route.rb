require_relative 'instance_counter.rb'
require_relative 'validation.rb'
require_relative 'accessors.rb'

class Route
  include InstanceCounter
  include Validation
  extend Accessors

  strong_attr_accessor(type: 'Station', name: 'stations')

  def initialize(stations = [])
    @stations = stations

    self.class.validate(obj: stations.first, validation: 'presence')
    self.class.validate(obj: stations.last, validation: 'presence')

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
