require_relative 'manufacturer.rb'
require_relative 'instance_counter.rb'
require_relative 'validation.rb'
require_relative 'accessors.rb'

class Train
  include Manufacturer
  include InstanceCounter
  include Validation
  extend Accessors

  NUMBER_FORMAT = /([a-zA-Z]|\d){3}-?([a-zA-Z]|\d){2}$/

  attr_reader :route
  attr_accessor_with_history :speed

  def initialize(number, manufacturer)
    self.manufacturer = manufacturer
    self.number = number
    self.speed = 0
    self.wagons_type = Train
    validate! self, self.class, NUMBER_FORMAT, number
    register_instance
  end

  def wagon_connect(wagon)
    return unless speed == 0
    self.wagons ||= []
    self.wagons = wagons + Array(wagon)
  end

  def wagon_disconnect(wagon)
    return unless speed == 0
    return unless Array(wagons).include?(wagon)
    wagons.delete(wagon)
  end

  def process_wagons
    wagons.each { |wagon| yield(wagon) }
  end

  def speed_gain(velocity)
    self.speed = speed + velocity
  end

  def stop
    self.speed = 0
  end

  def train_route=(route_set)
    self.route = route_set
    self.class.validate(obj: route_set, validation: 'presence')
    self.class.validate(obj: route_set, type: Route, validation: 'type')
    self.current_station_index = 0
    current_station.arriving_train(self)
  end

  def move_forward
    self.class.validate(obj: route, validation: 'presence')
    current_station.departure_train(self)
    @current_station_index += 1
    current_station.arriving_train(self)
  end

  def move_backward
    self.class.validate(obj: route, validation: 'presence')
    current_station.departure_train(self)
    @current_station_index -= 1
    current_station.arriving_train(self)
  end

  def current_station
    self.class.validate(obj: route, validation: 'presence')
    route.stations[@current_station_index]
  end

  def passed_station
    self.class.validate(obj: route, validation: 'presence')
    route.stations[@current_station_index - 1]
  end

  def next_station
    self.class.validate(obj: route, validation: 'presence')
    route.stations[@current_station_index + 1]
  end

  private

  attr_writer :route
  attr_accessor :current_station_index
  strong_attr_accessor(type: 'Wagon', name: 'wagons')
end
